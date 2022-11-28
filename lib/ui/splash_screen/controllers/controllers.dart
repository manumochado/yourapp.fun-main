import 'package:flutter/cupertino.dart';

class ControllersSplashScreen {
  String pathHome = "/home";

  navigateHome(context) {
    Navigator.pushNamed(context, pathHome);
  }
}
