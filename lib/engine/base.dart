import 'package:flutter/material.dart';
import 'package:quizal/engine/environments.dart';
import 'package:quizal/engine/routes.dart';
import 'package:quizal/engine/themes.dart';
import 'package:quizal/features/dashboard/dashboard_page.dart';
import 'package:sizer/sizer.dart';

///
/// Created by alfianhpratama on 28/05/23
///

class MyApp extends StatelessWidget {
  static final navigator = GlobalKey<NavigatorState>();

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: Environment.appName,
        debugShowCheckedModeBanner: false,
        navigatorKey: navigator,
        theme: AppTheme.darkTheme,
        onGenerateRoute: Routes.generateRoute,
        builder: (BuildContext context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child ?? Container(),
          );
        },
        initialRoute: DashboardPage.routeName,
      );
    });
  }
}
