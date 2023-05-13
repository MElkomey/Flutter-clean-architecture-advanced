

import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed_data_classes.freezed.dart';

///we will make auto generated file like in api Client service using factory and the command line
@freezed
class LoginObject with _$LoginObject{

  factory LoginObject(String userName,String password)=_LoginObject;
  ///used to be able change in any class argument in any func in one line in viewModel
}