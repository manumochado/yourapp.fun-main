import 'package:flutter/material.dart';
import 'package:go_app_v2/helpers/get_device_shop.dart';
import 'package:go_app_v2/i18n/strings.g.dart';
import 'package:url_launcher/url_launcher.dart'; // import

getModalExternalApp(context, url) {
  // set up the button
  Widget okButton = GestureDetector(
    child: Image.asset(t.buttonSliderModalExternal),
    onTap: () {
      // launch(Platform.isAndroid ? item.playStoreURL : item.appStoreURL);
      launchUrl(Uri.parse(url));
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "${t.titleSliderModalExternal} ${getDeviceShop()}",
      textAlign: TextAlign.center,
      style: TextStyle(fontFamily: 'Rubik'),
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
