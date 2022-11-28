import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:go_app_v2/data/data_wallpaper.dart';
import 'package:go_app_v2/helpers/get_device_ads.dart';
import 'package:go_app_v2/ui/widgets/home/app_bar.dart';
import 'package:go_app_v2/ui/widgets/home/background.dart';
import 'package:go_app_v2/ui/widgets/home/slider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

class Wallpaper extends StatefulWidget {
  Wallpaper({Key? key}) : super(key: key);

  @override
  State<Wallpaper> createState() => _WallpaperState();
}

class _WallpaperState extends State<Wallpaper> {
  int _currentImage = 0;
  List<String> _images = [];
  RewardedAd? _interstitialAd = null;
  bool _isInterstitialAdLoaded = false;
  bool dowloadImage = false;
  String imagePath = "";
  BannerAd? _bannerAd = null;

  @override
  void didChangeDependencies() {
    // _initAds();

    _initImages();
    setState(() {
      dowloadImage = false;
      imagePath = "";
    });
    super.didChangeDependencies();
  }

  void _initAds() {
    RewardedAd.load(
        adUnitId: getDeviceRewarned(),
        request: AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
            onAdLoaded: _onAdLoaded, onAdFailedToLoad: _onAdFailedToLoad));
    _bannerAd = BannerAd(
        adUnitId: getDeviceBanner(),
        size: AdSize.banner,
        listener: BannerAdListener(),
        request: AdRequest());
    _bannerAd!.load();

    // _bannerAd = BannerAd(
    //     adUnitId: AdsHelper.bannerAdUnitId,
    //     size: AdSize.banner,
    //     listener: BannerAdListener(),
    //     request: AdRequest());
    // _bannerAd.load();
  }

  void _onAdLoaded(RewardedAd ad) {
    _interstitialAd = ad;
    _isInterstitialAdLoaded = true;
    _interstitialAd!.fullScreenContentCallback =
        FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) async {
      // _interstitialAd.dispose();
      // _navigateToQuiz();
      _disposeAds();
      var imagePath = _images[_currentImage];
      final ByteData bytes = await rootBundle.load(imagePath);
      final Uint8List pngBytes = bytes.buffer.asUint8List();
      final String dir = (await getApplicationDocumentsDirectory()).path;
      final String fullPath = '$dir/${DateTime.now().millisecond}.png';
      File capturedFile = File(fullPath);
      await capturedFile.writeAsBytes(pngBytes);
      await GallerySaver.saveImage(capturedFile.path).then((value) {
        setState(() {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Go company'),
              content: const Text("Imagen guardada, revisa tu galería"),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                )
              ],
            ),
          );
        });
      });
      setState(() {
        dowloadImage = true;
      });
    }, onAdFailedToShowFullScreenContent: (ad, error) {
      _interstitialAd!.dispose();
    });
  }

  void _onAdFailedToLoad(LoadAdError error) {}

  void _displayInterstitialAd() {
    if (_isInterstitialAdLoaded) {
      _interstitialAd!.show(
          onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
        setState(() {
          // _disposeAds();
        });
        // Reward the user for watching an ad.
      });
    } else {}
  }

  @override
  void dispose() {
    _disposeAds();
    _bannerAd!.dispose();
    super.dispose();
  }

  void _disposeAds() {
    if (_interstitialAd != null) {
      _interstitialAd!.dispose();
    }
    _isInterstitialAdLoaded = false;
  }

  Future _initImages() async {
    // >> To get paths you need these 2 lines
    final manifestContent =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines

    final imagePaths =
        manifestMap.keys.where((String key) => key.contains('dummy/')).toList();

    setState(() {
      _images = imagePaths;
    });
  }

  @override
  Widget build(BuildContext context) {
    _initAds();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            getAppBar(),
            getSliderImage(context),
            Expanded(
                child: Container(
              child: _listView(),
            )),
            SafeArea(
              child: Container(
                  width: double.infinity,
                  height: 70,
                  child: AdWidget(ad: _bannerAd!)),
            )
          ],
        ),
      ),
    );
  }

  _listView() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          getBackGround(),
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  CarouselSliderWidget(),
                  WallpaperSelector()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget WallpaperSelector() {
    return Container(
      margin: EdgeInsets.only(top: 14),
      child: Column(
        children: [
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.only(right: 14, left: 14),
            child: Row(
              children: [
                Platform.isAndroid
                    ? InkWell(
                        child: Image.asset(
                          'assets/Wallpaper/ic_set_wallpaper.png',
                          width: 50,
                          height: 50,
                        ),
                        onTap: () async {
                          /*var imagePath = _images[_currentImage];
                    int location = WallpaperManager.BOTH_SCREENS;
                    final String result =
                        await WallpaperManager.setWallpaperFromAssetWithCrop(
                            imagePath, location, 0, 0, 800, 800);
                    print(result);
                    */
                          _displayInterstitialAd();

                          int location = WallpaperManagerFlutter
                              .HOME_SCREEN; //Choose screen type

                          WallpaperManagerFlutter().setwallpaperfromFile(
                              _images[_currentImage], location);
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Go company'),
                              content: const Text("Fondo de pantalla fijado"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                )
                              ],
                            ),
                          );
                        },
                      )
                    : Container(),
                Spacer(),
                Container(
                  width: 140,
                  height: 70,
                  child: Image.asset('assets/Wallpaper/slide_wallpaper.gif',
                      gaplessPlayback: true),
                ),
                Spacer(),
                InkWell(
                  child: Image.asset(
                    'assets/Wallpaper/ic_download.png',
                    width: 50,
                    height: 50,
                  ),
                  onTap: () async {
                    setState(() {
                      imagePath = _images[_currentImage].toString();
                    });
                    _displayInterstitialAd();
                    if (dowloadImage == true) {
                      setState(() {
                        dowloadImage = false;
                      });
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget CarouselSliderWidget() {
    return _images.length == 0
        ? Container()
        : CarouselSlider.builder(
            itemCount: _images.length,
            options: CarouselOptions(
                autoPlay: false,
                enlargeCenterPage: true,
                viewportFraction: 0.9,
                aspectRatio: 1.1,
                initialPage: 0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentImage = index;
                  });
                }),
            itemBuilder: (context, index, other) {
              return WallpaperImage(image: _images[index]);
            });
  }

  Widget WallpaperImage({image}) {
    return Container(
      //width: imageWidth,
      //height: imageHeight,
      decoration: BoxDecoration(
          image: DecorationImage(fit: BoxFit.cover, image: AssetImage(image)),
          borderRadius: BorderRadius.all(Radius.circular(50.0))),
    );
  }
}
