import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_advanced/domain/usecase/login_usecase.dart';
import 'package:flutter_advanced/presentation/base/baseviewmodel.dart';
import 'package:flutter_advanced/presentation/common/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInput, LoginViewModelOutput {
  StreamController _userNameStreamController =
      StreamController<String>.broadcast();

  ///broadcast will make the stream has many listners
  StreamController _passwordStreamController =
      StreamController<String>.broadcast();

  ///for the disabled and enabled button
  StreamController _areAllInputValidStreamController =
      StreamController<void>.broadcast();

  ///broadcast will make the stream has many listners
  var loginObject = LoginObject("", "");

  ///use the  login use case
  final LoginUseCase _loginUseCase;
  LoginViewModel(this._loginUseCase);

//inputs
  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
    _areAllInputValidStreamController.close();
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputAreAllInputValid => _areAllInputValidStreamController.sink;

  @override
  login() async {
    ///using fold with Future<Either<Failure, Authentication>> return type for left and right
    (await _loginUseCase.execute(
            LoginUseCaseInput(loginObject.userName, loginObject.password)))
        .fold(
            (failure) => {
                  ///l for left (failure)
                  if (kDebugMode) print(failure.message)
                },
            (data) => {
                  ///r for right (success)
                  if (kDebugMode) print(data.customer?.name)
                });
  }

  @override
  setPassword(String password) {
    _passwordStreamController.add(password);

    ///made by the auto generated file in common/freezed_data_classed
    loginObject = loginObject.copyWith(password: password);

    inputAreAllInputValid.add(null);
  }

  @override
  setUserName(String userName) {
    _userNameStreamController.add(userName);

    ///made by the auto generated file in common/freezed_data_classed
    loginObject = loginObject.copyWith(userName: userName);
    inputAreAllInputValid.add(null);
  }

  //outputs2
  @override
  Stream<bool> get outIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  Stream<bool> get outAreAllInputValid =>
      _areAllInputValidStreamController.stream.map((_) => _areAllInputsValid());

  bool _isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _areAllInputsValid() {
    return _isUserNameValid(loginObject.userName) &&
        _isPasswordValid(loginObject.password);
  }
}

abstract class LoginViewModelInput {
  setUserName(String userName);
  setPassword(String password);

  Sink get inputUserName;
  Sink get inputPassword;
  Sink get inputAreAllInputValid;

  login();
}

abstract class LoginViewModelOutput {
  Stream<bool> get outIsUserNameValid;
  Stream<bool> get outIsPasswordValid;
  Stream<bool> get outAreAllInputValid;
}
