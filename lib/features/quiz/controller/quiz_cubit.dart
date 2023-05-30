import 'dart:async';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quizal/engine/controller.dart';
import 'package:quizal/engine/options.dart';
import 'package:quizal/features/result/result_page.dart';
import 'package:quizal/model/answer.dart';
import 'package:quizal/model/quiz.dart';
import 'package:quizal/model/topic.dart';
import 'package:quizal/utils/helpers/notify.dart';

part 'quiz_state.dart';

part 'quiz_cubit.freezed.dart';

class QuizCubit extends BaseCubit<QuizState> {
  final BuildContext context;
  final Topic topic;
  List<Quiz> quiz = [];
  List<Answer> answer = [];
  Timer? _timer;
  int _timerCount = 0;
  int _currentIndexQuiz = 0;

  QuizCubit(this.context, this.topic) : super(const QuizState()) {
    getData();
  }

  @override
  Future<void> getData() async {
    await Future.delayed(const Duration(milliseconds: 500));
    quiz = topic.quiz ?? [];
    if (quiz.isNotEmpty) {
      quiz.shuffle();
      _currentIndexQuiz = 0;
      emit(state.copyWith(activeQuiz: quiz[_currentIndexQuiz], timer: 0));
      _runTimer();
    } else {
      ShowNotify.error(msg: 'No Quiz Data');
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  void onChooseAnswer(int idQuiz, String value) async {
    answer.add(Answer(idQuiz: idQuiz, answer: value));
    _checkFinalQuiz();
  }

  void _checkFinalQuiz() async {
    if (_currentIndexQuiz + 1 == quiz.length) {
      Navigator.pushReplacementNamed(context, ResultPage.routeName,
          arguments: ResultArgument(quiz: quiz, answer: answer));
    } else {
      ++_currentIndexQuiz;
      emit(state.copyWith(activeQuiz: quiz[_currentIndexQuiz]));
      _runTimer();
    }
  }

  void _runTimer() async {
    if (_timer != null) _timer?.cancel();
    _timerCount = 0;
    _timer = Timer.periodic(const Duration(milliseconds: 1), (Timer timer) {
      if (_timerCount >= 20000) {
        timer.cancel();
        emit(state.copyWith(timer: 1.0));
        _checkFinalQuiz();
      } else {
        ++_timerCount;
        emit(state.copyWith(timer: _timerCount / 20000));
      }
    });
  }
}
