import 'package:flutter/foundation.dart';

class QuizModel {
  final String questionId;
  final String artistId;
  final int level;
  final String question;
  final List<String> answers;
  final int correctIndex;

  QuizModel(
      {required this.questionId,
      required this.artistId,
      required this.level,
      required this.question,
      required this.answers,
      required this.correctIndex});

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      questionId: json["question_id"],
      artistId: json["artist_id"],
      level: json["level"],
      question: json["question"],
      answers: json["answers"].cast<String>(),
      correctIndex: json["correctIndex"],
    );
  }
}
