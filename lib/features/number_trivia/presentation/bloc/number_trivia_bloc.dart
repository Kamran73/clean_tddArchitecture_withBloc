import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider_state_management/core/usecases/usecases.dart';
import 'package:provider_state_management/features/number_trivia/domain/entities/number_trivia.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/input_converter.dart';
import '../../domain/use_cases/get_concerete_number_trivia.dart';
import '../../domain/use_cases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';

part 'number_trivia_state.dart';

const String serverFailureMessage = "Server Failure";
const String cacheFailureMessage = "Cache Failure";
const String inputConverterFailureMessage =
    "Invalid input - The number must be a positive integer or zero.";

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    required this.getConcreteNumberTrivia,
    required this.getRandomNumberTrivia,
    required this.inputConverter,
  }) : super(Empty()) {
    on<NumberTriviaEvent>((event, emit) async {
      if (event is GetTriviaForConcreteNumber) {
        final Either<Failures, int> inputEither = await Future.value(inputConverter.stringToUnsignedInteger(str: event.numberString));
       await  inputEither.fold((failure)async {
          emit(const Error(message: inputConverterFailureMessage));
        }, (integer) async {
          emit(Loading());
          await _getConcreteNumberTrivia(integer, emit);
        });
      } else if (event is GetTriviaForRandomNumber) {
        emit(Loading());
        final Either<Failures, NumberTrivia> randomNumberTriviaResult =
            await getRandomNumberTrivia(NoParams());
        randomNumberTriviaResult.fold(
            (failure) => emit(Error(message: _mapFailureToMessage(failure))),
            (numberTrivia) => emit(Loaded(numberTrivia: numberTrivia)));
      }
    });
  }

  String _mapFailureToMessage(Failures failure) {
    switch (failure.runtimeType) {
      case SeverFailure:
        return serverFailureMessage;
      case CacheFailure:
        return cacheFailureMessage;
      default:
        return "Unexpected error";
    }
  }

  Future<void> _getConcreteNumberTrivia(
      int integer, Emitter<NumberTriviaState> emit) async {
    final failureOrNumberTrivia =
        await getConcreteNumberTrivia(Params(number: integer));
    debugPrint(" failure and trivia is ${failureOrNumberTrivia.toString()}");
    await failureOrNumberTrivia.fold((failure) async{
      emit(Error(message: _mapFailureToMessage(failure)));
    }, (numberTrivia) async {
      emit(Loaded(numberTrivia: numberTrivia));
    });
  }
}
