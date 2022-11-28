import 'package:flutter/material.dart';
import 'package:go_app_v2/data/data_splash_screen.dart';
import 'package:go_app_v2/main.dart';
import 'package:go_app_v2/ui/splash_screen/controllers/controllers.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  final ControllersSplashScreen _controllers = ControllersSplashScreen();

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(DataSplashScreen().url)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    _controller.setLooping(false);
    _controller.play();
    _controller.addListener(() {
      setState(() {
        if (!_controller.value.isPlaying &&
            _controller.value.isInitialized &&
            (_controller.value.duration == _controller.value.position)) {
          //checking the duration and position every time
          //Video Completed//
          _controllers.navigateHome(context);
          prefsMain.setString("load", "true");
          setState(() {});
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: videoContainer());
  }

  Widget videoContainer() {
    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: _controller.value.size.width,
          height: _controller.value.size.height,
          child: VideoPlayer(_controller),
        ),
      ),
    );
  }
}
