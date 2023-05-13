

import 'package:dio/dio.dart';
import 'package:flutter_advanced/app/constants.dart';
import 'package:flutter_advanced/data/response/responses.dart';
import 'package:retrofit/http.dart';
part 'app_api.g.dart';


@RestApi(baseUrl:Constants.baseUrl)
abstract class AppServiceClient{
factory AppServiceClient(Dio dio,{String? baseUrl})=>_AppServiceClient;
/// run the same command in terminal for auto generated file like json_serializable
/// flutter pub get first then flutter pub run build_runner build --delete-conflicting-outputs

@POST("/customers/login")
  Future <AuthenticationResponse> login(
    @Field("email") String email,
    @Field("password") String password,
    );
///run the same command again

}