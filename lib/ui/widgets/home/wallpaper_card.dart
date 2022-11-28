import 'package:go_app_v2/i18n/strings.g.dart'; // import
import 'package:flutter/material.dart';
import 'package:go_app_v2/ui/home/controllers/controllers.dart';

getWallpaperCard(context) {
  return Container(
      margin: const EdgeInsets.only(top: 14),
      child: InkWell(
        onTap: () {
          // Navigator.pushNamed(context, WallpapersScreen.routeName);
          ControllersHome().getNavigateWallpaper(context);
        },
        child: Stack(
          children: [
            Image.asset(
              t.imageWallPaper,
            ),
            Positioned.fill(
                child: Row(
              children: [
                Container(
                    padding: const EdgeInsets.only(bottom: 35, left: 30),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "${t.titleWallPaper} \n ${t.subTitleWallPaper}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18),
                        textAlign: TextAlign.start,
                      ),
                    )),
                Spacer(),
                Container(
                    margin: const EdgeInsets.only(right: 14),
                    height: 120,
                    width: 120,
                    child: Stack(
                      children: [Image.asset("assets/Ref1/base_wallpaper.png")],
                    ))
              ],
            ))
          ],
        ),
      ));
}
