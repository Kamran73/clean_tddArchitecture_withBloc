import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class NetworkInfo{
  Future<bool> get  isConnected;
}

class NetworkInfoImpl implements NetworkInfo{
  final InternetConnectionCheckerPlus connectionCheckerPlus;
  NetworkInfoImpl({required this.connectionCheckerPlus});
  @override
  Future<bool> get isConnected =>
    connectionCheckerPlus.hasConnection;
}