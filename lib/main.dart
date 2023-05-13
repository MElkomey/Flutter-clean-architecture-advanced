import 'package:flutter/material.dart';
import 'package:flutter_advanced/app/app.dart';
import 'package:flutter_advanced/app/di.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //dependency injection
  await initAppModule();

  runApp( MyApp());
}
