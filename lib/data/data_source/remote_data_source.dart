import 'package:flutter_advanced/data/network/app_api.dart';
import 'package:flutter_advanced/data/network/requests.dart';
import 'package:flutter_advanced/data/response/responses.dart';

/// i want to call app service client in data layer
abstract class RemoteDataSource{
  ///this function is different from login function in domain layer because domain layer doesn't know ant thing about network data
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
}

class RemoteDataSourceImpl implements RemoteDataSource{

  final AppServiceClient _appServiceClient;
  RemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async{
   return  await _appServiceClient.login(loginRequest.email,loginRequest.password);
  }

}