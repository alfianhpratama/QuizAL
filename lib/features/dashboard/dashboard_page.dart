import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizal/engine/environments.dart';
import 'package:quizal/features/dashboard/controller/dashboard_cubit.dart';
import 'package:quizal/utils/helpers/notify.dart';
import 'package:quizal/utils/resources/assets.gen.dart';
import 'package:quizal/utils/widgets/primary_button.dart';
import 'package:quizal/utils/widgets/stroke_button.dart';
import 'package:sizer/sizer.dart';

///
/// Created by alfianhpratama on 28/05/23
///

class DashboardPage extends StatelessWidget {
  static const String routeName = '/';

  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DashboardCubit>(
      create: (context) => DashboardCubit(context),
      child: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DashboardCubit>();
    return Scaffold(
      appBar: AppBar(),
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 14.h),
        child: RepaintBoundary(
          key: cubit.resultKey,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 9.w),
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Assets.icApp.svg(height: 10.h),
                SizedBox(height: 7.h),
                Text(
                  'Flutter Quiz App',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold, fontSize: 16.sp),
                ),
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Learn'),
                    SizedBox(width: 1.w),
                    Icon(Icons.circle, size: 1.5.w),
                    SizedBox(width: 1.w),
                    const Text('Take Quiz'),
                    SizedBox(width: 1.w),
                    Icon(Icons.circle, size: 1.5.w),
                    SizedBox(width: 1.w),
                    const Text('Repeat'),
                  ],
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  width: double.infinity,
                  child: PrimaryButton(
                    onClick: cubit.onClickPlay,
                    title: 'Play',
                  ),
                ),
                SizedBox(height: 1.h),
                SizedBox(
                  width: double.infinity,
                  child: StrokeButton(
                    onClick: cubit.onClickTopics,
                    title: 'Topics',
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: cubit.onClickShare,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.share,
                              color: Theme.of(context).primaryColor),
                          SizedBox(width: 1.w),
                          const Text('Share'),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => ShowNotify.show(msg: 'Coming Soon'),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star, color: Colors.amber),
                          SizedBox(width: 1.w),
                          const Text('Rate Us'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Version ${Environment.appVersion}'),
          SizedBox(height: 0.5.w),
          Text(
            'Developed by alfianhpratama',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          SizedBox(height: 5.w),
        ],
      ),
    );
  }
}
