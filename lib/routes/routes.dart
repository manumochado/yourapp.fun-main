import 'package:go_app_v2/ui/game/game.dart';
import 'package:go_app_v2/ui/home/home.dart';
import 'package:go_app_v2/ui/our_apps/our_apps.dart';
import 'package:go_app_v2/ui/splash_screen/splash_scree.dart';
import 'package:go_app_v2/ui/wallpaper/wallpaper.dart';

getRoutes() {
  return {
    "/splash-screen": (context) => SplashScreen(),
    "/home": (context) => Home(),
    "/home/our-apps": (context) => OurApps(),
    "/home/wallpaper": (context) => Wallpaper(),
    "/game": (context) => Game(),
  };
}
