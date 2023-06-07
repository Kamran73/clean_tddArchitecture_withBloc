import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:provider_state_management/core/error/failures.dart';

abstract class UseCases<Type, Params>{
  Future<Either<Failures, Type>> call(Params params);
}
class NoParams extends Equatable{
  @override
  List<Object?> get props => throw UnimplementedError();
}