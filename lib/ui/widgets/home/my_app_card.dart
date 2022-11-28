import 'package:go_app_v2/i18n/strings.g.dart'; // import
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

getMyAppCard() {
  String video = "https://youtu.be/w_ezWG1yKQQ";

  return Container(
      margin: const EdgeInsets.only(top: 14),
      child: InkWell(
        onTap: () async {
          // Uri _url = Uri.parse(InitialScreen.iWantVideoURL);
          // if (!await launchUrl(_url)) throw 'Could not launch $_url';
          launchUrl(Uri.parse(video));
        },
        child: Stack(
          children: [
            Image.asset(t.imageMyApp),
            Positioned.fill(
                child: Container(
                    padding: const EdgeInsets.only(bottom: 45, left: 30),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${t.titleMyApp} \n ${t.subTitleMyApp} \n ${t.subTitle2MyApp} ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 14),
                      ),
                    )))
          ],
        ),
      ));
}
