import 'package:flutter/material.dart';
import 'ui/home.dart';
import 'ui/LoginScreen.dart';
import 'package:flutter/services.dart';
import 'helper/login_helper.dart';

void main() async {
  LoginHelper helper = LoginHelper();
  //get login_id e token
  String logado = await helper.getLogado();
  int login_id = await helper.getLogadoid();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  runApp(MaterialApp(
    home: (logado != null) ? HomePage(logado, login_id) : LoginScreen(),
    debugShowCheckedModeBanner: false,
  ));
}
