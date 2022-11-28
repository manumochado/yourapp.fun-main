import 'package:flutter/material.dart';
import 'package:go_app_v2/i18n/strings.g.dart';
import 'package:url_launcher/url_launcher.dart'; // import

getAppBar() {
  String goAppWeb = "https://www.gocompany.dev/";
  String privacidadWeb =
      "https://gocompany.dev/politica_de_privacidad_gocompany.pdf";

  return Container(
    width: double.infinity,
    height: 50,
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              launchUrl(Uri.parse(goAppWeb));
            },
            child: Text("GO COMPANY"),
          ),
          Row(
            children: [
              GestureDetector(
                  onTap: () {
                    launchUrl(Uri.parse(privacidadWeb));
                  },
                  child: Image.asset(t.imagePrivacity, width: 100)),
            ],
          )
        ],
      ),
    ),
  );
}
