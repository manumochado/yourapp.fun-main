import 'package:flutter/material.dart';
import 'package:go_app_v2/i18n/strings.g.dart';
import 'package:go_app_v2/routes/routes.dart';
import 'package:go_app_v2/ui/our_apps/our_apps.dart';
import 'package:go_app_v2/ui/wallpaper/wallpaper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefsMain;
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // add thi
  prefsMain = await SharedPreferences.getInstance();
  prefsMain.setString("load", "false");
  prefsMain.setString("level1", "false");
  prefsMain.setString("level2", "false");
  prefsMain.setString("level3", "false");
  prefsMain.setString("level4", "false");
  prefsMain.setString("level5", "false");

  MobileAds.instance.initialize();

  LocaleSettings.useDeviceLocale(); // and this
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Go App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      routes: getRoutes(),
      initialRoute: "/home",
    );
  }
}
