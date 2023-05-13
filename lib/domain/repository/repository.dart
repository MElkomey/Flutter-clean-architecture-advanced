
import 'package:dartz/dartz.dart';
import 'package:flutter_advanced/data/network/failure.dart';
import 'package:flutter_advanced/data/network/requests.dart';
import 'package:flutter_advanced/domain/model/models.dart';

///to implement the login api function
abstract class Repository{
  ///Either<left(bad,failure),right(good,success)>
  ///login must return here an authentication object as we are in domain layer
  Future<Either<Failure,Authentication>> login(LoginRequest loginRequest);
}