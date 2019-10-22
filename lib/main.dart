import 'package:flutter/material.dart';
import 'helper/Api.dart';
import 'ui/home.dart';
import 'ui/LoginScreen.dart';
import 'package:flutter/services.dart';
import 'helper/login_helper.dart';

void main() async {
  LoginHelper helper = LoginHelper();

  String logado = await helper.getLogado();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  runApp(MaterialApp(
    home: (logado != null) ? HomePage(logado) : LoginScreen(),
    debugShowCheckedModeBanner: false,
  ));
}
