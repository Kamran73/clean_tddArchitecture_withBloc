import 'package:dartz/dartz.dart';
import 'package:provider_state_management/core/error/exceptions.dart';
import 'package:provider_state_management/core/error/failures.dart';
import 'package:provider_state_management/features/number_trivia/data/data_sources/number_trivia_local_data_source.dart';
import 'package:provider_state_management/features/number_trivia/data/data_sources/number_trivia_remote_data_source.dart';
import 'package:provider_state_management/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:provider_state_management/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import '../../../../core/network_info/network_info.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository{
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  const NumberTriviaRepositoryImpl({required this.localDataSource, required this.networkInfo, required this.remoteDataSource});
  @override
  Future<Either<Failures, NumberTrivia>> getConcreteNumberTrivia(int number)async {
    if(await networkInfo.isConnected){
      try{
        final numberTriviaModel = await remoteDataSource.getConcreteNumberTrivia(number);
        await localDataSource.cacheNumberTrivia(numberTriviaModel);
        return Right(numberTriviaModel);
      } on ServerException{
        return Left(SeverFailure());
      }
    }
    else{
      try{
        final numberTriviaModel = await localDataSource.getLastNumberTrivia();
        return Right(numberTriviaModel);
      } on CacheException{
        return Left(CacheFailure());
      }
    }


  }

  @override
  Future<Either<Failures, NumberTrivia>> getRandomNumberTrivia() async {
    if(await networkInfo.isConnected){
      try{
        final numberTriviaModel = await remoteDataSource.getRandomNumberTrivia();
        localDataSource.cacheNumberTrivia(numberTriviaModel);
        return Right(numberTriviaModel);
      } on ServerException{
        return Left(SeverFailure());
      }
    }
    else{
      try{
        final numberTriviaModel = await localDataSource.getLastNumberTrivia();
        return Right(numberTriviaModel);
      } on CacheException{
        return Left(CacheFailure());
      }
    }
  }

}