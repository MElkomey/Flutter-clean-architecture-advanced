import 'package:dartz/dartz.dart';
import 'package:flutter_advanced/data/data_source/remote_data_source.dart';
import 'package:flutter_advanced/data/mapper/mapper.dart';
import 'package:flutter_advanced/data/network/error_handler.dart';
import 'package:flutter_advanced/data/network/failure.dart';
import 'package:flutter_advanced/data/network/network_info.dart';
import 'package:flutter_advanced/data/network/requests.dart';
import 'package:flutter_advanced/domain/model/models.dart';
import 'package:flutter_advanced/domain/repository/repository.dart';

class RepositoryImpl implements Repository{
  final RemoteDataSourceImpl _remoteDataSourceImpl;
  final NetworkInfo _networkInfo;
  RepositoryImpl(this._remoteDataSourceImpl,this._networkInfo);
  @override
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest) async{
    if(await _networkInfo.isConnected){
      try{
        final  response=await _remoteDataSourceImpl.login(loginRequest);
        if(response.status== ApiInternalStatus.SUCCESS){
          //success //return Either right//return data
          return Right(response.toDomain());
        }else{
          //failure //return Either left
          return Left(Failure(ApiInternalStatus.FAILURE,response.message ??ResponseMessage.DEFAULT));
        }
      }catch(error){
        return Left(ErrorHandler.handle(error).failure);
      }

    }else{
      //return no internet connection //return Either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

}