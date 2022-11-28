import 'package:go_app_v2/i18n/strings.g.dart'; // import
import 'package:flutter/material.dart';
import 'package:go_app_v2/ui/home/controllers/controllers.dart';

getRandomCard(context) {
  return Container(
      margin: const EdgeInsets.only(top: 14),
      child: InkWell(
        onTap: () {
          ControllersHome().getNavigateOurApps(context);
        },
        child: Stack(
          children: [
            Image.asset(t.imageRandom),
            Positioned.fill(
                child: Container(
                    padding: const EdgeInsets.only(bottom: 45, left: 30),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "   ${t.titleRandom}  \n ${t.subTitleRandom}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18),
                      ),
                    )))
          ],
        ),
      ));
}
