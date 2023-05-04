import 'package:provider_state_management/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider_state_management/features/number_trivia/domain/use_cases/get_concerete_number_trivia.dart';
class MockNumberTriviaRepository extends Mock implements NumberTriviaRepository{

}

void main(){
  GetConcreteNumberTrivia useCase;
  MockNumberTriviaRepository mockNumberTriviaRepository;
  setUp((){
     mockNumberTriviaRepository = MockNumberTriviaRepository();
     useCase = GetConcreteNumberTrivia( repository: mockNumberTriviaRepository);
  });
}