import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider_state_management/core/utils/input_converter.dart';

void main(){
  late InputConverter inputConverter;
  setUp(() {
    inputConverter = InputConverter();
  });
  
  group('group of multiple input types for testing InputConverter', () {

      test('should return integer when string represents and unsigned integer', () async{
         // arrange
         const String str = '123';
         // set
         final result = inputConverter.stringToUnsignedInteger(str: str);
         // assert
          expect(const Right(123), result);
       });

        test('should return failure when string is not integer', () async{
          // arrange
          const String str = 'abc';
          // set
          final result = inputConverter.stringToUnsignedInteger(str: str);
          // assert
          expect( Left(InvalidInputFailure()), result);
         });

      test('should return failure when string is negative number', () async{
        // arrange
        const String str = '-123';
        // set
        final result = inputConverter.stringToUnsignedInteger(str: str);
        // assert
        expect( Left(InvalidInputFailure()), result);
      });
  });


}