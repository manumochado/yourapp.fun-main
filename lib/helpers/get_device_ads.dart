import 'dart:io';

getDeviceInterstial() {
  if (Platform.isAndroid) {
    return "ca-app-pub-3940256099942544/1033173712";
  } else {
    return "ca-app-pub-3940256099942544/4411468910";
  }
}

getDeviceRewarned() {
  if (Platform.isAndroid) {
    return "ca-app-pub-3940256099942544/5224354917";
  } else {
    return "ca-app-pub-3940256099942544/1712485313";
  }
}

getDeviceBanner() {
  if (Platform.isAndroid) {
    return "ca-app-pub-3940256099942544/6300978111";
  } else {
    return "ca-app-pub-3940256099942544/2934735716";
  }
}
