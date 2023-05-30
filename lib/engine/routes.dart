import 'package:flutter/material.dart';
import 'package:quizal/features/dashboard/dashboard_page.dart';
import 'package:quizal/features/quiz/quiz_page.dart';
import 'package:quizal/features/result/result_page.dart';
import 'package:quizal/features/topic/topic_page.dart';
import 'package:quizal/model/topic.dart';

///
/// Created by alfianhpratama on 28/05/23
///

class Routes {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case DashboardPage.routeName:
        return _buildRoute(settings, (context) => const DashboardPage());
      case QuizPage.routeName:
        Topic topic = settings.arguments as Topic;
        return _buildRoute(settings, (context) => QuizPage(topic: topic));
      case ResultPage.routeName:
        ResultArgument argument = settings.arguments as ResultArgument;
        return _buildRoute(
            settings, (context) => ResultPage(argument: argument));
      case TopicPage.routeName:
        return _buildRoute(settings, (context) => const TopicPage());
      default:
        return _buildRoute(settings, (context) {
          return Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          );
        });
    }
  }

  static _buildRoute(RouteSettings settings,
          Widget Function(BuildContext context) builder) =>
      MaterialPageRoute(settings: settings, builder: builder);
}
