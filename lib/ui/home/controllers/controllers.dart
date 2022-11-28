import 'package:flutter/material.dart';

class ControllersHome {
  String routeOurAppsPath = "/home/our-apps";
  String routeWallpaperPath = "/home/wallpaper";

  getNavigateOurApps(context) {
    Navigator.pushNamed(context, routeOurAppsPath);
  }

  getNavigateWallpaper(context) {
    Navigator.pushNamed(context, routeWallpaperPath);
  }
}
