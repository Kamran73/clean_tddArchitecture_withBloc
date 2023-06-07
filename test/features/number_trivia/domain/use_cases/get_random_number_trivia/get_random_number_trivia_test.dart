import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider_state_management/core/usecases/usecases.dart';
import 'package:provider_state_management/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:provider_state_management/features/number_trivia/domain/use_cases/get_random_number_trivia.dart';

import '../get_concrete_number_trivia/get_concrete_number_trivia_test.mocks.dart';


void main() {
  late MockNumberTriviaRepository mockNumberTriviaRepository;
  late GetRandomNumberTrivia getRandomNumberTriviaUseCase;

  setUp((){
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    getRandomNumberTriviaUseCase = GetRandomNumberTrivia(repository: mockNumberTriviaRepository);
  });

  NumberTrivia expectedTrivia = const NumberTrivia(text: 'random trivia result', number: 5);
    test('', () async{
       // arrange
      when(mockNumberTriviaRepository.getRandomNumberTrivia()).thenAnswer ((_) async => Right(expectedTrivia));

      // set
      final result  = await getRandomNumberTriviaUseCase(NoParams());

       // assert

      expect(result, Right(expectedTrivia));
      verify(mockNumberTriviaRepository.getRandomNumberTrivia());
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    });

}