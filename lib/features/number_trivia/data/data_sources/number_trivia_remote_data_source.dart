import 'dart:convert';

import 'package:provider_state_management/core/error/exceptions.dart';

import '../models/number_trivia_model.dart';
import 'package:http/http.dart' as http;
abstract class NumberTriviaRemoteDataSource {

  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource{
  final http.Client client;
  NumberTriviaRemoteDataSourceImpl({required this.client});
  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async {
    final http.Response response = await  client.get(
      Uri.parse('http://numbersapi.com/$number'),
      headers: {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': '*/*'
      },
    );
    if(response.statusCode == 200){
      return NumberTriviaModel.fromJson(jsonDecode(response.body));
    }
    else{
      throw ServerException();
    }
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async {
    final http.Response response = await  client.get(
      Uri.parse('http://numbersapi.com/random/trivia'),
      headers: {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': '*/*'
      },
    );
    if(response.statusCode == 200){
      return NumberTriviaModel.fromJson(jsonDecode(response.body));
    }
    else{
      throw ServerException();
    }
  }

}