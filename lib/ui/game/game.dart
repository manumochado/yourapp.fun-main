import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_app_v2/data/data_game.dart';
import 'package:go_app_v2/helpers/audio_looper_helper.dart';
import 'package:go_app_v2/helpers/go_colors.dart';
import 'package:go_app_v2/helpers/quiz_model.dart';
import 'package:go_app_v2/providers/quiz_provider.dart';

import 'dart:async';

import 'package:provider/provider.dart';

class Game extends StatefulWidget {
  static const routeName = '/QuizScreen';

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  AudioHelper soundtrack =
      AudioHelper(filePath: 'assets/Sonidos/soundtrack_trivia.mp3');
  AudioHelper startSoundtrack = AudioHelper(
      filePath: 'assets/Ref2/Bum Y Cohete.mp3',
      id: AudioHelper.PLAYER_SOUND_ID);
  AudioHelper correctIncorrectAnswerAudio = AudioHelper(
      filePath: 'assets/Ref2/correct.mp3', id: AudioHelper.PLAYER_SOUND_ID);
  int level = 0;
  List dataGame = getDataGameLevel1();
  // Resources
  AssetImage _background = AssetImage('assets/Ref2/Bum-Y-Cohete.gif');
  AssetImage _correctQuizOption = AssetImage("assets/Ref2/Correcto.png");
  AssetImage _incorrectQuizOption = AssetImage("assets/Ref2/Incorrecto.png");
  AssetImage _quizOption = AssetImage("assets/Ref2/Respuestas.png");

  // Quiz models
  late List<QuizModel> _quizList;
  QuizModel? _quiz = null;

  // Quiz action propeties
  late int? _tappedIndex;
  int currentQuestion = 0;
  int correctAnswers = 0;
  bool _allowTap = false;

  // Header bar animation counter
  late AnimationController _counterController;
  static const int _animationTime = 20;

  // Quiz animation properties
  /// Enter animation properties
  late AnimationController _enterAnimationControllerQuestion;
  late AnimationController _enterAnimationControllerAnswer1;
  late AnimationController _enterAnimationControllerAnswer2;
  late AnimationController _enterAnimationControllerAnswer3;
  late AnimationController _enterAnimationControllerAnswer4;
  late Animation<double> _animationFadeQuestion;
  late Animation<double> _animationFadeAnswer1;
  late Animation<double> _animationFadeAnswer2;
  late Animation<double> _animationFadeAnswer3;
  late Animation<double> _animationFadeAnswer4;

  /// Exit animation properties
  late AnimationController _exitAnimationControllerQuestion;
  late AnimationController _exitAnimationControllerAnswer1;
  late AnimationController _exitAnimationControllerAnswer2;
  late AnimationController _exitAnimationControllerAnswer3;
  late AnimationController _exitAnimationControllerAnswer4;
  late Animation<Offset> _animationSlideQuestion;
  late Animation<Offset> _animationSlideAnswer1;
  late Animation<Offset> _animationSlideAnswer2;
  late Animation<Offset> _animationSlideAnswer3;
  late Animation<Offset> _animationSlideAnswer4;

  // Footer animation properties
  late AnimationController _footerController;
  late Animation<Offset> _footerAnimation;

  // General animation duration
  static const int _answerQuestionsAnimationDuration = 250;

  void timesUp() async {
    startQuizExitAnimations();
  }

  void loadQuestion() async {
    _tappedIndex = null;
    currentQuestion++;
    setState(() {
      level++;
    });
    _counterController.dispose();
    if (currentQuestion > _quizList.length) {
      // Navigator.of(context).pushReplacementNamed(ResultsScreen.routeName,
      //     arguments: correctAnswers > 3);
    } else {
      _quiz =
          _quizList.firstWhere((element) => element.level == currentQuestion);
      setState(() {});
    }
  }

  @override
  void initState() {
    _counterController = AnimationController(vsync: this);
    Future.delayed(Duration.zero, () {
      // double volume =
      //     Provider.of<SoundStateProvider>(context, listen: false).generalVolume;
      // print('VOLUME');
      // print(volume);
      // if (volume == 0) {
      //   startSoundtrack.mute();
      // } else {
      //   startSoundtrack.unMute();
      // }
    });

    WidgetsBinding.instance.addObserver(this);
    startSoundtrack.play();
    startSoundtrack.setPlayerEventListener((state) {
      if (state == PlayerState.COMPLETED) {
        soundtrack.play();
      }
    });

    correctIncorrectAnswerAudio.setPlayerEventListener((state) {
      if (state == PlayerState.COMPLETED) {
        correctIncorrectAnswerAudio.release();
      }
    });

    QuizListProvider().loadJson().then((value) {
      _quizList = value;
      loadQuestion();
    });

    setUpQuizAnimationControllers();
    setUpFooterAnimations();
    startFooterAnimations();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    precacheImage(_correctQuizOption, context);
    precacheImage(_incorrectQuizOption, context);
    precacheImage(_quizOption, context);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        soundtrack.play();
        break;
      default:
        startSoundtrack.release();
        soundtrack.release();
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    startSoundtrack.release();
    // Header bar animation counter
    _counterController.dispose();
    // Quiz animation properties
    _enterAnimationControllerQuestion.dispose();
    _enterAnimationControllerAnswer1.dispose();
    _enterAnimationControllerAnswer2.dispose();
    _enterAnimationControllerAnswer3.dispose();
    _enterAnimationControllerAnswer4.dispose();
    _exitAnimationControllerQuestion.dispose();
    _exitAnimationControllerAnswer1.dispose();
    _exitAnimationControllerAnswer2.dispose();
    _exitAnimationControllerAnswer3.dispose();
    _exitAnimationControllerAnswer4.dispose();
    // Footer animation properties
    _footerController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.black,
      child: QuizForm(),
    ));
  }

  Widget QuizForm() {
    _background.evict();

    return Stack(
      children: [
        Align(
            child: Image(
          image: _background,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.fill,
        )),
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  SafeArea(
                      child: _counterController == null
                          ? Container()
                          : Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                LinearProgressIndicator(
                                  minHeight: 40,
                                  value: _counterController.value,
                                  backgroundColor: GoColors.TimeBarBackground,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      GoColors.TimeBar),
                                ),
                                Container(
                                    margin: EdgeInsets.only(right: 14),
                                    child: Row(
                                      children: [
                                        Spacer(),
                                        Text(
                                          (_animationTime -
                                                      _counterController.value *
                                                          _animationTime)
                                                  .ceil()
                                                  .toString() +
                                              '"',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ))
                              ],
                            )),
                  QuizList(),
                ],
              ),
            ),
            SafeArea(
                child: SlideTransition(
              position: _footerAnimation,
              child: Column(
                children: [
                  Spacer(),
                  Image.asset("assets/Ref2/AyudaBloque.png", fit: BoxFit.fill),
                  Container(
                    margin: const EdgeInsets.only(bottom: 4, top: 10),
                    height: 40,
                    child: Row(
                      children: [
                        Spacer(),
                        Image.asset("assets/Ref2/Boton Eliminar 2.png"),
                        Container(
                          color: Colors.black,
                          width: 1,
                          margin: EdgeInsets.only(left: 7, right: 7),
                        ),
                        Image.asset("assets/Ref2/Boton Pasar.png"),
                        Spacer()
                      ],
                    ),
                  )
                ],
              ),
            ))
          ],
        )
      ],
    );
  }

  Widget QuizList() {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 10),
          Builder(builder: (context) {
            switch (level) {
              case 1:
                return _levels(0);
              case 2:
                return _levels(1);
              case 3:
                return _levels(2);
              case 4:
                return _levels(3);
              case 5:
                return _levels(4);
              default:
                return Container();
            }
          }),
        ],
      ),
    );
  }

  Column _levels(index) {
    return Column(
      children: [
        SlideTransition(
            position: _animationSlideQuestion,
            child: FadeTransition(
              opacity: _animationFadeQuestion,
              child: Container(
                margin: const EdgeInsets.only(
                    right: 20, left: 20, bottom: 20, top: 0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset("assets/Ref2/Escritura.png", fit: BoxFit.fill),
                    Text(dataGame[index]['question'])
                  ],
                ),
              ),
            )),
        SlideTransition(
            position: _animationSlideAnswer1,
            child: FadeTransition(
              opacity: _animationFadeAnswer1,
              child: QuizListElement(
                  question: dataGame[index]['answers'][0],
                  isCorrect: dataGame[index]['correctIndex'] == 0,
                  index: 0),
            )),
        SlideTransition(
            position: _animationSlideAnswer2,
            child: FadeTransition(
              opacity: _animationFadeAnswer2,
              child: QuizListElement(
                  question: dataGame[index]['answers'][1],
                  isCorrect: dataGame[index]['correctIndex'] == 1,
                  index: 1),
            )),
        SlideTransition(
            position: _animationSlideAnswer3,
            child: FadeTransition(
              opacity: _animationFadeAnswer3,
              child: QuizListElement(
                  question: dataGame[index]['answers'][2],
                  isCorrect: dataGame[index]['correctIndex'] == 2,
                  index: 2),
            )),
        SlideTransition(
            position: _animationSlideAnswer4,
            child: FadeTransition(
              opacity: _animationFadeAnswer4,
              child: QuizListElement(
                  question: dataGame[index]['answers'][3],
                  isCorrect: dataGame[index]['correctIndex'] == 3,
                  index: 3,
                  ind: dataGame[index]['correctIndex']),
            ))
      ],
    );
  }

  Widget QuizListElement({question: String, isCorrect: bool, index: int, ind}) {
    bool _isTapped = false;

    return GestureDetector(
      onTapUp: _allowTap
          ? (detail) async {
              if (_tappedIndex == null) {
                _tappedIndex = index;
                correctIncorrectAnswerAudio.setFilePath =
                    'assets/Ref2/incorrect.mp3';
                if (index == ind) {
                  correctAnswers++;
                  correctIncorrectAnswerAudio.setFilePath =
                      'assets/Ref2/correct.mp3';
                }
                correctIncorrectAnswerAudio.play();
                setState(() {});
                await Future.delayed(Duration(seconds: 1));
                startQuizExitAnimations();
              }
            }
          : null,
      child: Container(
        margin: const EdgeInsets.only(right: 14, left: 14, bottom: 14),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            (_tappedIndex != null && _tappedIndex == index)
                ? (isCorrect
                    ? Image(image: _correctQuizOption, fit: BoxFit.fill)
                    : Image(image: _incorrectQuizOption, fit: BoxFit.fill))
                : Image(image: _quizOption, fit: BoxFit.fill),
            Text(
              question,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  void setUpQuizEnterAnimations() {
    _enterAnimationControllerQuestion = AnimationController(
      duration: const Duration(milliseconds: _answerQuestionsAnimationDuration),
      vsync: this,
    );

    _enterAnimationControllerAnswer1 = AnimationController(
      duration: const Duration(milliseconds: _answerQuestionsAnimationDuration),
      vsync: this,
    );

    _enterAnimationControllerAnswer2 = AnimationController(
      duration: const Duration(milliseconds: _answerQuestionsAnimationDuration),
      vsync: this,
    );

    _enterAnimationControllerAnswer3 = AnimationController(
      duration: const Duration(milliseconds: _answerQuestionsAnimationDuration),
      vsync: this,
    );

    _enterAnimationControllerAnswer4 = AnimationController(
      duration: const Duration(milliseconds: _answerQuestionsAnimationDuration),
      vsync: this,
    );

    _animationFadeQuestion = CurvedAnimation(
      parent: _enterAnimationControllerQuestion,
      curve: Curves.easeIn,
    );

    _animationFadeAnswer1 = CurvedAnimation(
      parent: _enterAnimationControllerAnswer1,
      curve: Curves.easeIn,
    );

    _animationFadeAnswer2 = CurvedAnimation(
      parent: _enterAnimationControllerAnswer2,
      curve: Curves.easeIn,
    );

    _animationFadeAnswer3 = CurvedAnimation(
      parent: _enterAnimationControllerAnswer3,
      curve: Curves.easeIn,
    );

    _animationFadeAnswer4 = CurvedAnimation(
      parent: _enterAnimationControllerAnswer4,
      curve: Curves.easeIn,
    );
  }

  void setUpQuizExitAnimations() {
    _exitAnimationControllerQuestion = AnimationController(
      duration: const Duration(milliseconds: _answerQuestionsAnimationDuration),
      vsync: this,
    );

    _exitAnimationControllerAnswer1 = AnimationController(
      duration: const Duration(milliseconds: _answerQuestionsAnimationDuration),
      vsync: this,
    );

    _exitAnimationControllerAnswer2 = AnimationController(
      duration: const Duration(milliseconds: _answerQuestionsAnimationDuration),
      vsync: this,
    );

    _exitAnimationControllerAnswer3 = AnimationController(
      duration: const Duration(milliseconds: _answerQuestionsAnimationDuration),
      vsync: this,
    );

    _exitAnimationControllerAnswer4 = AnimationController(
      duration: const Duration(milliseconds: _answerQuestionsAnimationDuration),
      vsync: this,
    );

    final Curve exitAnimation = Curves.fastOutSlowIn;
    final Offset exitOffset = const Offset(1, 0);

    _animationSlideQuestion = Tween<Offset>(
      begin: Offset.zero,
      end: exitOffset,
    ).animate(CurvedAnimation(
      parent: _exitAnimationControllerQuestion,
      curve: exitAnimation,
    ));

    _animationSlideAnswer1 = Tween<Offset>(
      begin: Offset.zero,
      end: exitOffset,
    ).animate(CurvedAnimation(
      parent: _exitAnimationControllerAnswer1,
      curve: exitAnimation,
    ));

    _animationSlideAnswer2 = Tween<Offset>(
      begin: Offset.zero,
      end: exitOffset,
    ).animate(CurvedAnimation(
      parent: _exitAnimationControllerAnswer2,
      curve: exitAnimation,
    ));

    _animationSlideAnswer3 = Tween<Offset>(
      begin: Offset.zero,
      end: exitOffset,
    ).animate(CurvedAnimation(
      parent: _exitAnimationControllerAnswer3,
      curve: exitAnimation,
    ));

    _animationSlideAnswer4 = Tween<Offset>(
      begin: Offset.zero,
      end: exitOffset,
    ).animate(CurvedAnimation(
      parent: _exitAnimationControllerAnswer4,
      curve: exitAnimation,
    ));
  }

  void setUpQuizAnimationControllers() {
    setUpQuizEnterAnimations();
    setUpQuizExitAnimations();
  }

  void startQuizEnterAnimations() {
    setState(() {
      _allowTap = false;
    });
    _enterAnimationControllerAnswer4.forward().whenComplete(() =>
        _enterAnimationControllerAnswer3.forward().whenComplete(() =>
            _enterAnimationControllerAnswer2.forward().whenComplete(() =>
                _enterAnimationControllerAnswer1.forward().whenComplete(() =>
                    _enterAnimationControllerQuestion
                        .forward()
                        .whenComplete(() => {
                              setState(() {
                                _allowTap = true;
                              }),
                              setUpTopBarCounter()
                            })))));
  }

  void startQuizExitAnimations() {
    _counterController.stop(
      canceled: false,
    );
    _exitAnimationControllerQuestion.forward().whenComplete(() =>
        _exitAnimationControllerAnswer1.forward().whenComplete(() =>
            _exitAnimationControllerAnswer2.forward().whenComplete(() =>
                _exitAnimationControllerAnswer3.forward().whenComplete(() =>
                    _exitAnimationControllerAnswer4
                        .forward()
                        .whenComplete(() => setUpNextAnswer())))));
  }

  void setUpTopBarCounter() {
    _counterController = AnimationController(
        vsync: this,
        duration: const Duration(
          seconds: _animationTime,
        ))
      ..addListener(() {
        if (_counterController.value == 1) {
          timesUp();
        }
        setState(() {});
      });

    _counterController.forward();
  }

  void setUpFooterAnimations() {
    _footerController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _footerAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _footerController,
      curve: Curves.decelerate,
    ));
  }

  void startFooterAnimations() async {
    await Future.delayed(Duration(seconds: 3));
    _footerController.forward().whenComplete(() => startQuizEnterAnimations());
  }

  void setUpNextAnswer() {
    _exitAnimationControllerQuestion.reset();
    _exitAnimationControllerAnswer1.reset();
    _exitAnimationControllerAnswer2.reset();
    _exitAnimationControllerAnswer3.reset();
    _exitAnimationControllerAnswer4.reset();
    setUpQuizEnterAnimations();
    loadQuestion();
    startQuizEnterAnimations();
  }
}
