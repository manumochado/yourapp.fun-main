import 'dart:io';

getDeviceShop() {
  if (Platform.isIOS) {
    return "App Store";
  } else {
    return "Play Store";
  }
}
