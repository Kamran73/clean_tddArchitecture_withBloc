import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:provider_state_management/core/usecases/usecases.dart';
import 'package:provider_state_management/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:provider_state_management/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import '../../../../core/error/failures.dart';

class GetConcreteNumberTrivia implements UseCases<NumberTrivia, Params>{
  NumberTriviaRepository  repository;
  GetConcreteNumberTrivia({required this.repository});
  @override
  Future<Either<Failures, NumberTrivia>> call(Params params) async {
    return await repository.getConcreteNumberTrivia(params.number);
  }

}
class Params extends Equatable{
  final int number;
  const Params({required this.number});
  @override
  List<Object?> get props => [number];
}