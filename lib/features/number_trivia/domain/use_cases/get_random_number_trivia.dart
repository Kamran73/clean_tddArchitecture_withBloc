import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:provider_state_management/core/usecases/usecases.dart';
import 'package:provider_state_management/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:provider_state_management/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import '../../../../core/error/failures.dart';

class GetRandomNumberTrivia implements UseCases<NumberTrivia, NoParams>{
  NumberTriviaRepository  repository;
  GetRandomNumberTrivia({required this.repository});
  @override
  Future<Either<Failures, NumberTrivia>> call(NoParams params) async {
    return await repository.getRandomNumberTrivia();
  }

}