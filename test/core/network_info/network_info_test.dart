import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider_state_management/core/network_info/network_info.dart';

import 'network_info_test.mocks.dart';
@GenerateMocks([InternetConnectionCheckerPlus])
void main(){
  late MockInternetConnectionCheckerPlus connectionCheckerPlus;
  late NetworkInfoImpl networkInfo;

  setUp(() {
    connectionCheckerPlus = MockInternetConnectionCheckerPlus();
    networkInfo = NetworkInfoImpl(connectionCheckerPlus: connectionCheckerPlus);
  });

    test('', () async{

       // arrange
       when(connectionCheckerPlus.hasConnection).thenAnswer((_) async => true);
       // set
       final networkInfoResult = await networkInfo.isConnected;
       // assert
        verify(connectionCheckerPlus.hasConnection);
        expect(true, networkInfoResult);
     });
}