import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_advanced/data/network/failure.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      // error from api or dio itself
      failure = _handleError(error);
    } else {
      //default error
      failure = DataSource.DEFAULT.getFailure();
    }
  }
}

Failure _handleError(DioError error) {
  switch (error.type) {
    case DioErrorType.connectTimeout:
      return DataSource.CONNECT_TIME_OUT.getFailure();
    case DioErrorType.sendTimeout:
      return DataSource.SEND_TIME_OUT.getFailure();
    case DioErrorType.receiveTimeout:
      return DataSource.RECIEVE_TIME_OUT.getFailure();
    case DioErrorType.response:
      if (error.response != null &&
          error.response?.statusCode != null &&
          error.response?.statusMessage != null) {
        return Failure(
            error.response!.statusCode!, error.response!.statusMessage!);
      } else {
        return DataSource.DEFAULT.getFailure();
      }
    case DioErrorType.cancel:
      return DataSource.CANCEL.getFailure();
    case DioErrorType.other:
      return DataSource.DEFAULT.getFailure();
  }
}

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORIZED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIME_OUT,
  CANCEL,
  RECIEVE_TIME_OUT,
  SEND_TIME_OUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT
}

extension DataSourceExtention on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.SUCCESS:
        return Failure(ResponseCode.SUCCESS, ResponseMessage.SUCCESS);
      case DataSource.NO_CONTENT:
        return Failure(ResponseCode.NO_CONTENT, ResponseMessage.NO_CONTENT);
      case DataSource.BAD_REQUEST:
        return Failure(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST);
      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN);
      case DataSource.UNAUTHORIZED:
        return Failure(ResponseCode.UNAUTHORIZED, ResponseMessage.UNAUTHORIZED);
      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND);
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(ResponseCode.INTERNAL_SERVER_ERROR,
            ResponseMessage.INTERNAL_SERVER_ERROR);
      case DataSource.CONNECT_TIME_OUT:
        return Failure(
            ResponseCode.CONNECT_TIME_OUT, ResponseMessage.CONNECT_TIME_OUT);
      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL);
      case DataSource.RECIEVE_TIME_OUT:
        return Failure(
            ResponseCode.RECIEVE_TIME_OUT, ResponseMessage.RECIEVE_TIME_OUT);
      case DataSource.CACHE_ERROR:
        return Failure(ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR);
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION);
      default:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
    }
  }
}

class ResponseCode {
  static const int SUCCESS = 200; //success with data
  static const int NO_CONTENT = 201; //success with no data
  static const int BAD_REQUEST = 400; //failure,api reject request
  static const int UNAUTHORIZED = 401; //failure, user not authorized
  static const int FORBIDDEN = 403; //failure,api reject request
  static const int NOT_FOUND = 404; //failure,not found
  static const int INTERNAL_SERVER_ERROR = 500; //crash in server side

  //local status code
  static const int CONNECT_TIME_OUT = -1;
  static const int CANCEL = -2;
  static const int RECIEVE_TIME_OUT = -3;
  static const int SEND_TIME_OUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFAULT = -7;
}

class ResponseMessage {
  static const String SUCCESS = "success"; //success with data
  static const String NO_CONTENT = "success"; //success with no data
  static const String BAD_REQUEST =
      "Bad request, Try again later"; //failure,api reject request
  static const String UNAUTHORIZED =
      "User is unauthorized ,Try again later"; //failure, user not authorized
  static const String FORBIDDEN =
      "Forbidden request, Try again later"; //failure,api reject request
  static const String NOT_FOUND =
      "Some thing went wrong, Try again later"; //failure,api reject request
  static const String INTERNAL_SERVER_ERROR =
      "Some thing went wrong, Try again later"; //crash in server side

  //local status code
  static const String CONNECT_TIME_OUT = "Time out, Try again later";
  static const String CANCEL = "Request was cancelled, Try again later";
  static const String RECIEVE_TIME_OUT = "Time out, Try again later";
  static const String SEND_TIME_OUT = "Time out, Try again later";
  static const String CACHE_ERROR = "Cache error, Try again later";
  static const String NO_INTERNET_CONNECTION =
      "please check your internet connection";
  static const String DEFAULT = "Some thing went wrong, Try again later";
}

class ApiInternalStatus{
  static const int SUCCESS=0;
  static const int FAILURE=1;
}
