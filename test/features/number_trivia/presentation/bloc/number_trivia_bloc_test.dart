import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider_state_management/core/error/failures.dart';
import 'package:provider_state_management/core/usecases/usecases.dart';
import 'package:provider_state_management/core/utils/input_converter.dart';
import 'package:provider_state_management/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:provider_state_management/features/number_trivia/domain/use_cases/get_concerete_number_trivia.dart';
import 'package:provider_state_management/features/number_trivia/domain/use_cases/get_random_number_trivia.dart';
import 'package:provider_state_management/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'number_trivia_bloc_test.mocks.dart';

@GenerateMocks([GetConcreteNumberTrivia, GetRandomNumberTrivia, InputConverter])
void main() {
  late MockGetConcreteNumberTrivia getConcreteNumberTrivia;
  late MockGetRandomNumberTrivia getRandomNumberTrivia;
  late MockInputConverter inputConverter;
  late NumberTriviaBloc numberTriviaBloc;
  setUp(() {
    getConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    getRandomNumberTrivia = MockGetRandomNumberTrivia();
    inputConverter = MockInputConverter();
    numberTriviaBloc = NumberTriviaBloc(
        getConcreteNumberTrivia: getConcreteNumberTrivia,
        getRandomNumberTrivia: getRandomNumberTrivia,
        inputConverter: inputConverter);
  });

  group('get concrete number trivia', () {
    String stringNumber = "1";
    int returnedNumber = 1;
    const NumberTrivia numberTrivia = NumberTrivia(text: 'text', number: 1);
    test('should return Empty state when first time bloc is created', () async {
      // arrange

      // set

      // assert
      expect(numberTriviaBloc.state, Empty());
    });
    test(
        'should return Number trivia when get concrete number trivia called and input converter is called',
        () async {
      // arrange
      when(inputConverter.stringToUnsignedInteger(str: stringNumber))
          .thenReturn(Right(returnedNumber));
      when(getConcreteNumberTrivia(Params(number: returnedNumber))).thenAnswer((_)async => const Right(numberTrivia));

      // set
      numberTriviaBloc.add(GetTriviaForConcreteNumber(numberString: stringNumber));
      await untilCalled(
          inputConverter.stringToUnsignedInteger(str: stringNumber));

      // assert
      verify(inputConverter.stringToUnsignedInteger(str: stringNumber));
    });
    test(
        'should return input converter failure if conversion is not successful',
        () async* {
          //arrange
          when(inputConverter.stringToUnsignedInteger(str: "-3"))
              .thenReturn(Left(InvalidInputFailure()));

          final expected = [
            Empty(),
            const Error(message: inputConverterFailureMessage),
          ];
          //assert later
          expectLater(numberTriviaBloc.state, emitsInOrder(expected));

          //act
          numberTriviaBloc.add(GetTriviaForConcreteNumber(numberString: "-3"));
    });

    test(
        'should call getConcreteNumberTrivia use case when integer is successfully parsed',
            () async* {
          //arrange
          when(inputConverter.stringToUnsignedInteger(str: stringNumber))
              .thenReturn(Right(returnedNumber));
          when(getConcreteNumberTrivia(Params(number: returnedNumber))).thenAnswer((_)async => const Right(numberTrivia));
          //assert
          numberTriviaBloc.add(GetTriviaForConcreteNumber(numberString: stringNumber));
          await untilCalled(inputConverter.stringToUnsignedInteger(str: stringNumber));
          //act
          verify(inputConverter.stringToUnsignedInteger(str: stringNumber));
          verify(getConcreteNumberTrivia(Params(number: returnedNumber)));
        });

    test(
        'should return tNumberTrivia use case when integer is successfully parsed',
            () async* {
          //arrange
          when(inputConverter.stringToUnsignedInteger(str: stringNumber))
              .thenReturn(Right(returnedNumber));
          when(getConcreteNumberTrivia(Params(number: returnedNumber))).thenAnswer((_)async => const Right(numberTrivia));
          //assert
          numberTriviaBloc.add(GetTriviaForConcreteNumber(numberString: stringNumber));
         // await untilCalled(inputConverter.stringToUnsignedInteger(str: stringNumber));
          //act
          final expectedStates = [
            Empty(),
            Loading(),
            const Loaded(numberTrivia: numberTrivia),
          ];
          verify(inputConverter.stringToUnsignedInteger(str: stringNumber));
          verify(getConcreteNumberTrivia(Params(number: returnedNumber)));
          expectLater(numberTriviaBloc.state, emitsInOrder(expectedStates));
        });

    test(
        'should return server Failure when integer is successfully parsed but server throw any exception',
            () async* {
          //arrange
          when(inputConverter.stringToUnsignedInteger(str: stringNumber))
              .thenReturn(Right(returnedNumber));
          when(getConcreteNumberTrivia(Params(number: returnedNumber))).thenAnswer((_)async => Left(SeverFailure()));
          //assert
          numberTriviaBloc.add(GetTriviaForConcreteNumber(numberString: stringNumber));
         // await untilCalled(inputConverter.stringToUnsignedInteger(str: stringNumber));
          //act
          final expectedStates = [
            Empty(),
            Loading(),
            const Error(message: serverFailureMessage),
          ];
          verify(inputConverter.stringToUnsignedInteger(str: stringNumber));
          verify(getConcreteNumberTrivia(Params(number: returnedNumber)));
          expectLater(numberTriviaBloc.state, emitsInOrder(expectedStates));
        });
  });

  group('get random number trivia', () {
    String stringNumber = "1";
    int returnedNumber = 1;
    const NumberTrivia numberTrivia = NumberTrivia(text: 'text', number: 1);
    test('should return Empty state when first time bloc is created', () async {
      // arrange

      // set

      // assert
      expect(numberTriviaBloc.state, Empty());
    });


    test(
        'should call getRandomNumberTrivia use case when random number event is triggered',
            () async* {
          //arrange

          when(getRandomNumberTrivia(NoParams())).thenAnswer((_)async => const Right(numberTrivia));
          //assert
          numberTriviaBloc.add(GetTriviaForRandomNumber());

          //act
          verify(getRandomNumberTrivia(NoParams()));
        });

    test(
        'should return tNumberTrivia use case when integer is successfully parsed',
            () async* {
          //arrange
              when(getRandomNumberTrivia(NoParams())).thenAnswer((_)async => const Right(numberTrivia));          //assert
          numberTriviaBloc.add(GetTriviaForRandomNumber());
          //act
          final expectedStates = [
            Empty(),
            Loading(),
            const Loaded(numberTrivia: numberTrivia),
          ];
          verify(getRandomNumberTrivia(NoParams()));
          expectLater(numberTriviaBloc.state, emitsInOrder(expectedStates));
        });

    test(
        'should return Failure when server throw any exception',
            () async* {
          //arrange

          when(getRandomNumberTrivia(NoParams())).thenAnswer((_)async => Left(SeverFailure()));
          //assert
          numberTriviaBloc.add(GetTriviaForRandomNumber());
          //act
          final expectedStates = [
            Empty(),
            Loading(),
            const Error(message: serverFailureMessage),
          ];
          verify(getRandomNumberTrivia(NoParams()));
          expectLater(numberTriviaBloc.state, emitsInOrder(expectedStates));
        });
  });



}
