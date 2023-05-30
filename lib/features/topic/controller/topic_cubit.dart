import 'dart:async';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quizal/engine/controller.dart';
import 'package:quizal/engine/options.dart';
import 'package:quizal/features/quiz/quiz_page.dart';
import 'package:quizal/model/base_factory.dart';
import 'package:quizal/model/topic.dart';

part 'topic_state.dart';

part 'topic_cubit.freezed.dart';

class TopicCubit extends BaseCubit<TopicState> {
  final BuildContext context;
  List<Topic> allData = [];
  Timer? _timer;

  TopicCubit(this.context) : super(const TopicState()) {
    getData();
  }

  @override
  Future<void> getData() async {
    emit(state.copyWith(status: DataStateStatus.initial));
    await Future.delayed(const Duration(seconds: 1));
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    List<dynamic> res = (await ref.get()).value as List<dynamic>;
    ListFactory<Topic> response =
        ListFactory.fromJson(jsonDecode(jsonEncode(res)));
    List<Topic> result = response.data;
    allData = result;
    emit(state.copyWith(status: DataStateStatus.success, data: result));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  void onTypingSearch(String value) async {
    if (_timer != null) _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 600), () => _filterList(value));
  }

  void _filterList(String value) async {
    List<Topic> result = [];
    for (Topic t in allData) {
      if (t.topic.toLowerCase().contains(value.toLowerCase())) result.add(t);
    }
    emit(state.copyWith(data: result));
  }

  void onChooseTopic(Topic topic) =>
      Navigator.of(context).pushNamed(QuizPage.routeName, arguments: topic);
}
