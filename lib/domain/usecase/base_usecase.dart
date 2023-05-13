
import 'package:dartz/dartz.dart';
import 'package:flutter_advanced/data/network/failure.dart';

/// usecase is the gate where presentation layer talk to domain layer
abstract class BaseUseCase<In,Out>{
  Future<Either<Failure,Out>> execute(In input);
}