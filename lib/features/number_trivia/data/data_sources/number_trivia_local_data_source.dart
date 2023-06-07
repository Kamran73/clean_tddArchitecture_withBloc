import 'dart:convert';

import 'package:provider_state_management/core/error/exceptions.dart';
import 'package:provider_state_management/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NumberTriviaLocalDataSource{
  /// Gets the cached [NumberTriviaModel] which was gotten the last time
  /// if the user has an internet connection
  ///
  /// throws cacheException if no cached data is present
  Future<NumberTriviaModel> getLastNumberTrivia();

  /// calls the http endpoint
  /// throws error for all error codes
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);

}
const   cachedNumberTrivia = 'CACHED_NUMBER_TRIVIA';
class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource{



  final SharedPreferences sharedPreferences;
  NumberTriviaLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) async {
     sharedPreferences.setString(cachedNumberTrivia, json.encode(triviaToCache.toJson()));
     return;
  }

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final lastTrivia = sharedPreferences.getString(cachedNumberTrivia);
    if(lastTrivia != null){
      return Future.value(NumberTriviaModel.fromJson(jsonDecode(lastTrivia)));
    }
    else{
      throw CacheException();
    }
  }

}