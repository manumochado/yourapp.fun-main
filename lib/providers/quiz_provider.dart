import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:go_app_v2/helpers/quiz_model.dart';

enum QuizLevel { LEVEL_1, LEVEL_2, LEVEL_3, LEVEL_4 }

class QuizListProvider extends ChangeNotifier {
  List<QuizModel> _items = [];
  QuizLevel level = QuizLevel.LEVEL_2;

  List<QuizModel> get items {
    return [..._items];
  }

  Future<void> fetchQuizList() async {
    String data = await rootBundle.loadString('assets/QuizList.json');
    Iterable list = json.decode(data);
    print(list);
    _items =
        list.map((mappedObject) => QuizModel.fromJson(mappedObject)).toList();
    notifyListeners();
  }

  Future<List<QuizModel>> loadJson() async {
    String data = await rootBundle.loadString('assets/QuizList.json');
    Iterable list = json.decode(data);
    return list.map((model) => QuizModel.fromJson(model)).toList();
  }

  Future<void> fetchAndSearchAppItems(QuizLevel quizLevel) async {
    level = quizLevel;
    notifyListeners();
  }
}
