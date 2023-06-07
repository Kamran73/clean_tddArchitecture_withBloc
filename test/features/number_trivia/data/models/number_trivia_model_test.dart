import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:provider_state_management/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:provider_state_management/features/number_trivia/domain/entities/number_trivia.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tNumberTriviaModel = NumberTriviaModel(text: 'test text', number: 1);

  test('', () async {
    expect(tNumberTriviaModel, isA<NumberTrivia>());
  });
  group('fromJson', () {
    test('should return a valid model when the JSON number is integer',
        () async {
      // arrange
      final jsonResponse = jsonDecode(fixtureReader('trivia.json'));
      // set
      final numberTriviaModelTest = NumberTriviaModel.fromJson(jsonResponse);
      // assert
      expect(tNumberTriviaModel, numberTriviaModelTest);
    });

    test('should return a valid model when the JSON number is double',
        () async {
      // arrange
      final jsonResponse = jsonDecode(fixtureReader('trivia_double.json'));
      // set
      final numberTriviaModelTest = NumberTriviaModel.fromJson(jsonResponse);
      // assert
      expect(tNumberTriviaModel, numberTriviaModelTest);
    });
  });

  group('toJson', () {
      test('should return a valid Json map from NumberTriviaModel ', () async{
         // set
        final expectedOutputJson = tNumberTriviaModel.toJson();
        final originalJson = {
          'text' : 'test text',
          'number': 1
        };
         // assert
        expect(originalJson, expectedOutputJson);
       });
  });
}
