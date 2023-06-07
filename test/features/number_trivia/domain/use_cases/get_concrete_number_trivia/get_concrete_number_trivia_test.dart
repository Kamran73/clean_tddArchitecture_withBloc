import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:provider_state_management/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:provider_state_management/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider_state_management/features/number_trivia/domain/use_cases/get_concerete_number_trivia.dart';
import 'package:provider_state_management/core/error/failures.dart';

import 'get_concrete_number_trivia_test.mocks.dart';

@GenerateMocks([NumberTriviaRepository])

void main() {
  late MockNumberTriviaRepository mockNumberTriviaRepository;

  late GetConcreteNumberTrivia useCase ;
  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    useCase = GetConcreteNumberTrivia(repository: mockNumberTriviaRepository);
  });
  const tNumber = 1;
  const tNumberTrivia = NumberTrivia(text: "", number: tNumber);
    test('', () async{
      // arrange
      when(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber)).thenAnswer((_) async => const Right(tNumberTrivia));
      // set
      final result  = await useCase(const Params(number: tNumber));
      // assert
      expect(result , const Right<Failures, NumberTrivia>(tNumberTrivia));
      verify(await mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber));
      verifyNoMoreInteractions(mockNumberTriviaRepository);
     });
}
