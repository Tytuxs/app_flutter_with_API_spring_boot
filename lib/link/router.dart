import 'package:flutter/material.dart';
import 'package:app_flutter/screen/home.dart';

const String kLoginRoute = '/login';
const String kRegisterRoute = '/register';
const String kResetPasswordRoute = '/resetPassword';
const String pathHome = '/';
const String kError = '/error';

Map<String, WidgetBuilder> router = {
  pathHome: (context) =>  home(),
};