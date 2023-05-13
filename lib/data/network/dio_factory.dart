import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_advanced/app/app_prefs.dart';
import 'package:flutter_advanced/app/constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

//these constants are specialized for headers and used only here
const String APPLICATION_JSON="application/json";
const String CONTENT_TYPE="content-type";
const String ACCEPT="accept";
const String AUTHORIZATION="authorization";
const String DEFAULT_LANGUAGE="language";

class DioFactory{
  final AppPreferences _appPreferences;
  DioFactory(this._appPreferences);


 Dio dio=Dio();


 Future<Dio> getDio() async{
   String language= _appPreferences.getAppLanguage();

   Map<String,String> headers={
     CONTENT_TYPE:APPLICATION_JSON,
     ACCEPT:APPLICATION_JSON,
     AUTHORIZATION:Constants.token,
     DEFAULT_LANGUAGE: language,
   };

   dio.options=BaseOptions(
     baseUrl: Constants.baseUrl,
     headers: headers,
     receiveTimeout: Constants.apiTimeOut,
     sendTimeout: Constants.apiTimeOut
   );
   if(kDebugMode){
     dio.interceptors.add(PrettyDioLogger(
       requestHeader : true,
       requestBody : true,
       responseHeader : true
     ));
   }

   return dio;
 }
}