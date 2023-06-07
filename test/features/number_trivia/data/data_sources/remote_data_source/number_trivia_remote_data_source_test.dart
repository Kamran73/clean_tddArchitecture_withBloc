import 'dart:convert';

import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:provider_state_management/core/error/exceptions.dart';
import 'package:provider_state_management/features/number_trivia/data/data_sources/number_trivia_remote_data_source.dart';
import 'package:provider_state_management/features/number_trivia/data/models/number_trivia_model.dart';
import '../../../../../fixtures/fixture_reader.dart';
import 'number_trivia_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient httpClient;
  late NumberTriviaRemoteDataSourceImpl numberTriviaRemoteDataSourceImpl;

  setUp(() {
    httpClient = MockClient();
    numberTriviaRemoteDataSourceImpl =
        NumberTriviaRemoteDataSourceImpl(client: httpClient);
  });

  void setUpWhenStatusCodeIs200(){
    when(httpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async {
      return http.Response(fixtureReader('trivia.json'), 200);
    });
  }

  void setUpWhenStatusCodeIsNot200(){
    when(httpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async {
      return http.Response("some error occurred", 404);
    });
  }


  group('tests of getting concrete number trivia model from remote data source', () {
    const int tNumberTrivia = 1;
    final  NumberTriviaModel tNumberTriviaModel =  NumberTriviaModel.fromJson(jsonDecode(fixtureReader('trivia.json')));
    test('should verify http.get call when we call that function from our remote data source implementation', () async {
      // arrange
      setUpWhenStatusCodeIs200();
      // set
      numberTriviaRemoteDataSourceImpl.getConcreteNumberTrivia(tNumberTrivia);
      // assert
      verify(
        httpClient.get(
          Uri.parse('http://numbersapi.com/$tNumberTrivia'),
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
    });
    test('should return number trivia model when status code is 200', () async {

      // arrange
     setUpWhenStatusCodeIs200();
      // set
      final result  = await numberTriviaRemoteDataSourceImpl.getConcreteNumberTrivia(tNumberTrivia);
      // assert
      verify(
        httpClient.get(
          Uri.parse('http://numbersapi.com/$tNumberTrivia'),
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      expect(tNumberTriviaModel, equals(result));
    });
    test('should throw serverException when status code is other than 200', () async {

      // arrange
      setUpWhenStatusCodeIsNot200();
      // set
      final call = numberTriviaRemoteDataSourceImpl.getConcreteNumberTrivia;
      // assert
      expect(()async{ await call(tNumberTrivia);}, const Throws(TypeMatcher<ServerException>()));
    });
  });



  group('tests of getting random number trivia model from remote data source', () {
    const int tNumberTrivia = 1;
    final  NumberTriviaModel tNumberTriviaModel =  NumberTriviaModel.fromJson(jsonDecode(fixtureReader('trivia.json')));
    test('should verify http.get call when we call that function from our remote data source implementation', () async {
      // arrange
      setUpWhenStatusCodeIs200();
      // set
      numberTriviaRemoteDataSourceImpl.getRandomNumberTrivia();
      // assert
      verify(
        httpClient.get(
          Uri.parse('http://numbersapi.com/random'),
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
    });
    test('should return number trivia model when status code is 200', () async {

      // arrange
      setUpWhenStatusCodeIs200();
      // set
      final result  = await numberTriviaRemoteDataSourceImpl.getRandomNumberTrivia();
      // assert
      verify(
        httpClient.get(
          Uri.parse('http://numbersapi.com/random'),
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      expect(tNumberTriviaModel, equals(result));
    });
    test('should throw serverException when status code is other than 200', () async {

      // arrange
      setUpWhenStatusCodeIsNot200();
      // set
      final call = numberTriviaRemoteDataSourceImpl.getRandomNumberTrivia;
      // assert
      expect(()async{ await call();}, const Throws(TypeMatcher<ServerException>()));
    });
  });



}
