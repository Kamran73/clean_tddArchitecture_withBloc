part of 'number_trivia_bloc.dart';

abstract class NumberTriviaEvent extends Equatable {

  const NumberTriviaEvent() : super();
}

class GetTriviaForConcreteNumber extends NumberTriviaEvent{
  final String numberString;
  const GetTriviaForConcreteNumber({required this.numberString}) ;
  @override
  List<Object?> get props => [numberString];

}
class GetTriviaForRandomNumber extends NumberTriviaEvent{
  @override
  List<Object?> get props => throw UnimplementedError();

}