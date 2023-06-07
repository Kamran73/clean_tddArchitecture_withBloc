import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider_state_management/core/error/exceptions.dart';
import 'package:provider_state_management/features/number_trivia/data/data_sources/number_trivia_local_data_source.dart';
import 'package:provider_state_management/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../fixtures/fixture_reader.dart';
import 'data_sources_test.mocks.dart';
@GenerateMocks([SharedPreferences])

void main(){
  late NumberTriviaLocalDataSourceImpl numberTriviaLocalDataSourceImpl;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    numberTriviaLocalDataSourceImpl = NumberTriviaLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });
  
  group('should return NumberTriviaModel when getting data from last cached number trivia if available', () {
    final NumberTriviaModel tNumberTriviaModel = NumberTriviaModel.fromJson(jsonDecode(fixtureReader('trivia_cached.json')));
      test('return tNumberTriviaModel when calling mockSharedPreferences.getString', () async{
         // arrange
         when(mockSharedPreferences.getString(any)).thenReturn(
           fixtureReader('trivia_cached.json')
         );
         // set
         final result  = await numberTriviaLocalDataSourceImpl.getLastNumberTrivia();
         // assert
          verify(mockSharedPreferences.getString(cachedNumberTrivia));
          expect(result, tNumberTriviaModel);
       });
    test('return CacheException when no cache trivia is available', () async{
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(
          null
      );
      // set
      final result  = await  numberTriviaLocalDataSourceImpl.getLastNumberTrivia();
      // assert
      expect(result , const Throws(TypeMatcher<CacheException>()));
    });
  });
}
