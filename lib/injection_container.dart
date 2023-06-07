import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:provider_state_management/core/network_info/network_info.dart';
import 'package:provider_state_management/core/utils/input_converter.dart';
import 'package:provider_state_management/features/number_trivia/data/data_sources/number_trivia_local_data_source.dart';
import 'package:provider_state_management/features/number_trivia/data/data_sources/number_trivia_remote_data_source.dart';
import 'package:provider_state_management/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:provider_state_management/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:provider_state_management/features/number_trivia/domain/use_cases/get_concerete_number_trivia.dart';
import 'package:provider_state_management/features/number_trivia/domain/use_cases/get_random_number_trivia.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Number Trivia
  //Bloc
  sl.registerFactory(() => NumberTriviaBloc(
        getConcreteNumberTrivia: sl(),
        getRandomNumberTrivia: sl(),
        inputConverter: sl(),
      ));

  //Use cases
  sl.registerLazySingleton(() => GetConcreteNumberTrivia(
        repository: sl(),
      ));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(
        repository: sl(),
      ));

  //Repositories
  sl.registerLazySingleton<NumberTriviaRepository>(
      () => NumberTriviaRepositoryImpl(
            localDataSource: sl(),
            networkInfo: sl(),
            remoteDataSource: sl(),
          ));

  // Data sources
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(() => NumberTriviaRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<NumberTriviaLocalDataSource>(() => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()));
  // Core

  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectionCheckerPlus: sl()));

  // External

  final sharedPreferences = await  SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<InternetConnectionCheckerPlus>(() => InternetConnectionCheckerPlus());
  sl.registerLazySingleton<http.Client>(() => http.Client());
}
