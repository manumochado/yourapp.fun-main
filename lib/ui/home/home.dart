import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gif/gif.dart';
import 'package:go_app_v2/ui/home/controllers/controllers.dart';
import 'package:go_app_v2/ui/widgets/home/app_bar.dart';
import 'package:go_app_v2/ui/widgets/home/background.dart';
import 'package:go_app_v2/ui/widgets/home/my_app_card.dart';
import 'package:go_app_v2/ui/widgets/home/play_card.dart';
import 'package:go_app_v2/ui/widgets/home/random_card.dart';
import 'package:go_app_v2/ui/widgets/home/slider.dart';
import 'package:go_app_v2/ui/widgets/home/wallpaper_card.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  bool _showAppBar = true;
  ScrollController _controller = ScrollController();
  bool isScrollingDown = false;
  List homePlayer = [];
  AssetImage imageSound = AssetImage("assets/Ref1/de-off-a-on.gif");
  String imagePath = "assets/Ref1/de-off-a-on.gif";
  late final GifController controllerG;

  @override
  void initState() {
    // TODO: implement initState
    controllerG = GifController(vsync: this);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    _controller.addListener(() {
      setState(() {});
      if (_controller.position.userScrollDirection == ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          _showAppBar = false;
          setState(() {});
        }
      }

      if (_controller.position.userScrollDirection == ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          _showAppBar = true;
          setState(() {});
        }
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AnimatedContainer(
              height: _showAppBar ? 50 : 0,
              duration: Duration(milliseconds: 200),
              child: getAppBar(),
            ),
            getSliderImage(context),
            _listView()
          ],
        ),
      ),
    );
  }

  Expanded _listView() {
    return Expanded(
        child: Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          getBackGround(),
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                controller: _controller,
                children: [
                  _SoundsButton(),
                  GetPlayCard(),
                  getWallpaperCard(context),
                  getMyAppCard(),
                  getRandomCard(context)
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }

  Row _SoundsButton() {
    return Row(
      children: [
        Spacer(),
        ZoomTapAnimation(
          begin: 1.0,
          end: 0.75,
          child: Image.asset(
            "assets/Ref1/Boton Sonido Left.png",
            width: 44,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 50, left: 50),
          child: GestureDetector(
            onTapDown: (de) {
              if (imagePath == 'assets/Ref1/de-off-a-on.gif') {
                setState(() {
                  imagePath = 'assets/Ref1/de-on-a-off.gif';
                  imageSound = AssetImage(
                    'assets/Ref1/de-on-a-off.gif',
                  );
                });
              } else {
                setState(() {
                  imagePath = 'assets/Ref1/de-off-a-on.gif';

                  imageSound = AssetImage(
                    'assets/Ref1/de-off-a-on.gif',
                  );
                });
              }
            },
            onTap: () {},
            child: Gif(
              image: AssetImage(
                imagePath,
              ),
              width: 44,
              height: 44,
              controller:
                  controllerG, // if duration and fps is null, original gif fps will be used.
              //fps: 30,
              //duration: const Duration(seconds: 3),
              autostart: Autostart.once,
              placeholder: (context) => const Text('Loading...'),
              onFetchCompleted: () {},
            ),
          ),
        ),
        ZoomTapAnimation(
            begin: 1.0,
            end: 0.75,
            // onTap: () => {homePlayer.next()},
            child: Image.asset(
              "assets/Ref1/Boton Sonido Right.png",
              width: 44,
            )),
        Spacer()
      ],
    );
  }
}
