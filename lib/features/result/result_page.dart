import 'package:flutter/material.dart';
import 'package:quizal/model/answer.dart';
import 'package:quizal/model/quiz.dart';
import 'package:quizal/utils/helpers/render.dart';
import 'package:quizal/utils/widgets/primary_button.dart';
import 'package:sizer/sizer.dart';

///
/// Created by alfianhpratama on 28/05/23
///

class ResultArgument {
  final List<Quiz> quiz;
  final List<Answer> answer;

  ResultArgument({required this.quiz, required this.answer});
}

class ResultPage extends StatelessWidget {
  static const String routeName = '/result';
  final ResultArgument argument;

  const ResultPage({Key? key, required this.argument}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final resultKey = GlobalKey();

    int trueData = 0;
    for (Quiz q in argument.quiz) {
      for (Answer a in argument.answer) {
        if (a.idQuiz == q.id) {
          if (a.answer == q.answer) trueData++;
          break;
        }
      }
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Your Score')),
      body: Padding(
        padding: EdgeInsets.all(2.w),
        child: RepaintBoundary(
          key: resultKey,
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 4.w),
                  child: Center(
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 30.w,
                          width: 30.w,
                          child: Transform.flip(
                            flipX: true,
                            child: CircularProgressIndicator(
                              value: trueData / argument.quiz.length,
                              valueColor: Animation<Color>.fromValueListenable(
                                  ValueNotifier<Color>(Colors.green)),
                              backgroundColor: Colors.red,
                              strokeWidth: 1.5.w,
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: Center(
                            child: Text('$trueData / ${argument.quiz.length}'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                PrimaryButton(
                  onClick: () => Rendering.share(resultKey),
                  title: 'Share your score',
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                ),
                SizedBox(height: 4.w),
                Text(
                  'Your Report',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.w),
                ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    final Quiz quiz = argument.quiz[index];
                    bool isTrue = false;
                    String answer = 'null';

                    for (Answer a in argument.answer) {
                      if (a.idQuiz == quiz.id) {
                        answer = a.answer;
                        isTrue = answer == quiz.answer;
                        break;
                      }
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          quiz.question ?? '',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Row(
                          children: [
                            Visibility(
                              visible: !isTrue,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'X',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: Colors.red),
                                  ),
                                  SizedBox(width: 0.5.w),
                                  Text(answer),
                                  SizedBox(width: 2.w),
                                ],
                              ),
                            ),
                            const Icon(Icons.check, color: Colors.green),
                            SizedBox(width: 0.5.w),
                            Text('${quiz.answer}'),
                          ],
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (_, __) => SizedBox(height: 3.w),
                  itemCount: argument.quiz.length,
                ),
                SizedBox(height: 4.w),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
