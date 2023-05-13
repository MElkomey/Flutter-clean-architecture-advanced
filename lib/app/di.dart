
import 'package:dio/dio.dart';
import 'package:flutter_advanced/app/app_prefs.dart';
import 'package:flutter_advanced/data/data_source/remote_data_source.dart';
import 'package:flutter_advanced/data/network/app_api.dart';
import 'package:flutter_advanced/data/network/dio_factory.dart';
import 'package:flutter_advanced/data/network/network_info.dart';
import 'package:flutter_advanced/data/repository/repository_impl.dart';
import 'package:flutter_advanced/domain/repository/repository.dart';
import 'package:flutter_advanced/presentation/login/viewmodel/login_viewmodel.dart';
import 'package:flutter_advanced/presentation/login/viewmodel/login_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/usecase/login_usecase.dart';

///dependency injection file

final instance =GetIt.instance;

Future<void> initAppModule() async {
  ///this func is where we put all generic dependencies over the app module

  /// shared preferences instance
  final sharedPrefs= await SharedPreferences.getInstance();
  /// lazy single tone is better because it will not take memory place if i didn't call it
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  ///app preferences instance
  ///instance.registerLazySingleton<AppPreferences>(() =>AppPreferences(sharedPrefs));
  instance.registerLazySingleton<AppPreferences>(() =>AppPreferences(instance()));///instance is meaning that get_it will automatic get the required instance

 ///network info instance
  instance.registerLazySingleton<NetworkInfo>(()=>NetworkInfoImpl(InternetConnectionChecker()));

  ///Dio factory instance  ///explicit way
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance<AppPreferences>()));

  ///app service client
  Dio dio =await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() =>AppServiceClient(dio));

  ///remote data source
  instance.registerLazySingleton<RemoteDataSource>(() =>RemoteDataSourceImpl(instance()));

  ///repository
  instance.registerLazySingleton<Repository>(() => RepositoryImpl(instance(), instance()));
}

void loginAppModule() {  /// will be called in route manager before we go to loginScreen
/// we will use factory register
  if(! GetIt.I.isRegistered<LoginUseCase>()){
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }

}