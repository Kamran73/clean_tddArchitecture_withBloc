import 'package:equatable/equatable.dart';

class Failures extends Equatable{
  final List properties ;
  const Failures({this.properties = const <dynamic>[],}) : super();
  @override
  List<Object?> get props => [properties];
}

class SeverFailure extends Failures{}

class CacheFailure extends Failures{}