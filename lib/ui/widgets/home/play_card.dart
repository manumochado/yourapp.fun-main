import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_app_v2/helpers/get_device_ads.dart';
import 'package:go_app_v2/i18n/strings.g.dart';
import 'package:go_app_v2/main.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart'; // import

class GetPlayCard extends StatefulWidget {
  const GetPlayCard({super.key});

  @override
  State<GetPlayCard> createState() => _GetPlayCardState();
}

class _GetPlayCardState extends State<GetPlayCard> {
  bool _canShow = false;
  double _progress = 0.0;
  late Timer _timer;
  int _startPlayTimer = 200;
  InterstitialAd? _interstitialAd = null;
  bool _isInterstitialAdLoaded = false;
  bool finishedLoading = false;

  @override
  void initState() {
    // TODO: implement initState

    resetTimer();
    _initAds();
    super.initState();
  }

  @override
  void dispose() {
    _disposeAds();
    super.dispose();
  }

  void _disposeAds() {
    _interstitialAd!.dispose();
    _isInterstitialAdLoaded = false;
  }

  // void startTimer() {
  //   const oneSec = const Duration(seconds: 3);

  //   _timer = Timer.periodic(
  //     oneSec,
  //     (Timer timer) {
  //       setState(() {
  //         _progress += 0.05;
  //       });

  //       // if (_startPlayTimer == 0) {
  //       //   // resetTimer();
  //       //   setState(() {
  //       //     timer.cancel();
  //       //   });

  //       //   // _displayInterstitialAd();
  //       // } else {
  //       //   setState(() {
  //       //     print(_progress);

  //       //     _progress += 0.005;
  //       //     _startPlayTimer -= 1;
  //       //   });
  //       // }
  //     },
  //   );
  // }
  void startTimer() {
    const oneSec = Duration(milliseconds: 10);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_startPlayTimer == 0) {
          resetTimer();
          setState(() {
            timer.cancel();
          });
          if (finishedLoading == true) {
            if (prefsMain.getString("level1") == "false") {
              _displayInterstitialAd();
            } else {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Center(
                      child: Container(
                        child: Stack(
                          children: [
                            Center(
                              child: Image.asset(
                                "./assets/Ref1/levels.png",
                                width: 400,
                                height: 500,
                              ),
                            ),
                            Center(
                              child: Container(
                                width: 315,
                                height: 450,
                                child: Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 60,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Center(
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                width: 40,
                                                height: 40,
                                                color: Colors.transparent,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        child: ListView(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Image.asset("./assets/Ref1/nivel1.png"),
                                        Image.asset("./assets/Ref1/nivel2.png"),
                                        Image.asset(
                                            prefsMain.getString("level2") ==
                                                    "false"
                                                ? "./assets/Ref1/nivel3b.png"
                                                : "./assets/Ref1/nivel3.png"),
                                        Image.asset(
                                            prefsMain.getString("level3") ==
                                                    "false"
                                                ? "./assets/Ref1/nivel4b.png"
                                                : "./assets/Ref1/nivel4.png"),
                                        Image.asset(
                                            prefsMain.getString("level4") ==
                                                    "false"
                                                ? "./assets/Ref1/nivel5b.png"
                                                : "./assets/Ref1/nivel5.png")
                                      ],
                                    ))
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            }
          } else {}
        } else {
          setState(() {
            _progress += 0.005;
            _startPlayTimer -= 1;
          });
          // print("object1");
        }
      },
    );
  }

  void resetTimer() {
    setState(() {
      _timer = Timer(Duration(seconds: 0), () {});
      _progress = 0;
      PaintingBinding.instance.imageCache.clear();
      _canShow = false;
      _startPlayTimer = 200;
      _timer.cancel();
    });
  }

  void _initAds() {
    InterstitialAd.load(
        adUnitId: getDeviceInterstial(),
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: _onAdLoaded, onAdFailedToLoad: _onAdFailedToLoad));

    // _bannerAd = BannerAd(
    //     adUnitId: AdsHelper.bannerAdUnitId,
    //     size: AdSize.banner,
    //     listener: BannerAdListener(),
    //     request: AdRequest());
    // _bannerAd.load();
  }

  void _onAdLoaded(InterstitialAd ad) {
    _interstitialAd = ad;
    _isInterstitialAdLoaded = true;
    _interstitialAd!.fullScreenContentCallback =
        FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
      // _interstitialAd!.dispose();
      // _navigateToQuiz();
      // Navigator.pushNamed(context, "/game");
    }, onAdFailedToShowFullScreenContent: (ad, error) {
      _interstitialAd!.dispose();
    });
  }

  void _onAdFailedToLoad(LoadAdError error) {}

  void _displayInterstitialAd() {
    if (_isInterstitialAdLoaded) {
      _interstitialAd!.show();
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    // _initAds();
    return Container(
        margin: const EdgeInsets.only(top: 10),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, "/game");
          },
          onTapUp: (detail) {
            _canShow = false;

            // audioStarToPlay.play();
            resetTimer();
            // //validateSoundState();
            setState(() {});
          },
          onTapCancel: () {
            resetTimer();
            setState(() {
              _timer.cancel();
            });
          },
          // onLongPressStart: (details) {
          //   // resetTimer();

          //   // //validateSoundState();
          //   setState(() {
          //     _canShow = true;
          //   });
          //   startTimer();

          //   // audioHelper.play();
          // },
          // onLongPressEnd: (details) {
          //   // audioStarToPlay.play();
          //   setState(() {
          //     resetTimer();

          //     _canShow = false;
          //   });
          // },

          // onTapDown: (details) {
          //   //validateSoundState();

          // },
          onLongPressStart: (details) {
            setState(() {
              finishedLoading = true;
              resetTimer();
              _canShow = true;
              startTimer();
            });
          },
          onLongPressEnd: (details) {
            setState(() {
              finishedLoading = false;
              resetTimer();
            });
          },
          child: Stack(
            children: [
              Image.asset(t.imagePlayCard),
              Positioned.fill(
                  child: Row(
                children: [
                  Container(
                      width: 240,
                      padding: const EdgeInsets.only(bottom: 35, left: 30),
                      child: Text(
                        "${t.titlePLay} \n ${t.subtitlePLay}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis,
                            fontSize: 16),
                      )),
                  Flexible(
                      child: Row(
                    children: [
                      Spacer(),
                      Container(
                          margin: const EdgeInsets.only(right: 14),
                          height: 120,
                          width: 120,
                          child: Stack(
                            children: [
                              Image.asset("assets/Ref1/base_jugar.png"),
                            ],
                          ))
                    ],
                  )),
                ],
              )),
              ShowPlayLoader()

              // ShowPlayLoader()
            ],
          ),
        ));
  }

  //Loader
  Widget ShowPlayLoader() {
    return Positioned.fill(child: _canShow ? PlayLoader() : Container());
  }

  Widget PlayLoader() {
    return Row(
      children: [
        Spacer(),
        SizedBox(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(
              strokeWidth: 25,
              backgroundColor: Color(0xFFbecdd2),
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF72b7bc)),
              value: _progress,
            )),
        Spacer()
      ],
    );
  }
}
