import 'dart:convert';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quizal/engine/controller.dart';
import 'package:quizal/features/quiz/quiz_page.dart';
import 'package:quizal/features/topic/topic_page.dart';
import 'package:quizal/model/base_factory.dart';
import 'package:quizal/model/topic.dart';
import 'package:quizal/utils/helpers/notify.dart';
import 'package:quizal/utils/helpers/render.dart';

part 'dashboard_state.dart';

part 'dashboard_cubit.freezed.dart';

class DashboardCubit extends BaseCubit<DashboardState> {
  final resultKey = GlobalKey();
  final BuildContext context;

  DashboardCubit(this.context) : super(const DashboardState());

  @override
  Future<void> getData() async {}

  void onClickPlay() async {
    loadingDialog.show(cancelable: false);
    await Future.delayed(const Duration(seconds: 1));
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    List<dynamic> res = (await ref.get()).value as List<dynamic>;
    ListFactory<Topic> response =
        ListFactory.fromJson(jsonDecode(jsonEncode(res)));
    List<Topic> result = response.data;
    loadingDialog.dismiss();

    if (result.isNotEmpty) {
      Topic topic = result[Random().nextInt(result.length)];
      _gotoQuizPage(topic);
    } else {
      ShowNotify.error(msg: "No Quiz Data");
    }
  }

  void _gotoQuizPage(Topic topic) =>
      Navigator.pushNamed(context, QuizPage.routeName, arguments: topic);

  void onClickTopics() => Navigator.pushNamed(context, TopicPage.routeName);

  void onClickShare() => Rendering.share(resultKey);
}
