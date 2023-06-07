import 'package:dartz/dartz.dart';
import '../error/failures.dart';

class InputConverter{
  Either<Failures, int> stringToUnsignedInteger({required String str}){
    try{
      final integer = int.parse(str);
      if(integer < 0) throw const FormatException();
      return Right(int.parse(str));
    } on FormatException{
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failures{

}