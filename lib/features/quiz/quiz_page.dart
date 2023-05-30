import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizal/features/dashboard/dashboard_page.dart';
import 'package:quizal/features/quiz/controller/quiz_cubit.dart';
import 'package:quizal/model/topic.dart';
import 'package:quizal/utils/widgets/image_load.dart';
import 'package:quizal/utils/widgets/secondary_button.dart';
import 'package:sizer/sizer.dart';

///
/// Created by alfianhpratama on 28/05/23
///

class QuizPage extends StatelessWidget {
  static const String routeName = '/quiz';
  final Topic topic;

  const QuizPage({Key? key, required this.topic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuizCubit>(
      create: (context) => QuizCubit(context, topic),
      child: const QuizScreen(),
    );
  }
}

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<QuizCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Page'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context)
                .pushNamedAndRemoveUntil(DashboardPage.routeName, (_) => false),
            icon: const Text('Exit'),
          ),
          SizedBox(width: 2.w),
        ],
      ),
      body: BlocBuilder<QuizCubit, QuizState>(
        builder: (context, state) {
          return Column(
            children: [
              LinearProgressIndicator(value: state.timer),
              SizedBox(height: 4.w),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2.w),
                ),
                padding: EdgeInsets.all(4.w),
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      state.activeQuiz?.question ?? '',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Visibility(
                      visible: state.activeQuiz?.image != null &&
                          (state.activeQuiz?.image?.isNotEmpty ?? false),
                      child: SizedBox(height: 4.w),
                    ),
                    Visibility(
                      visible: state.activeQuiz?.image != null &&
                          (state.activeQuiz?.image?.isNotEmpty ?? false),
                      child: SizedBox(
                        height: 50.w,
                        child: ImageLoad(
                          imageUrl: '${state.activeQuiz?.image}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4.w),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                itemBuilder: (ctx, index) {
                  String value = '';
                  switch (index) {
                    case 0:
                      value = state.activeQuiz?.option1 ?? '';
                      break;
                    case 1:
                      value = state.activeQuiz?.option2 ?? '';
                      break;
                    case 2:
                      value = state.activeQuiz?.option3 ?? '';
                      break;
                    case 3:
                      value = state.activeQuiz?.option4 ?? '';
                      break;
                  }

                  return SizedBox(
                    width: double.infinity,
                    child: SecondaryButton(
                      onClick: () => cubit.onChooseAnswer(
                          state.activeQuiz?.id ?? 99, value),
                      title: value,
                    ),
                  );
                },
                separatorBuilder: (_, __) => SizedBox(height: 1.w),
                itemCount: 4,
              ),
            ],
          );
        },
      ),
    );
  }
}
