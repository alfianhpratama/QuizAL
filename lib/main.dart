import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:quizal/engine/base.dart';
import 'package:quizal/engine/environments.dart';
import 'package:quizal/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InitialApps.start();

  runApp(const MyApp());
}

class InitialApps {
  static start() async {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    Environment.appVersion = packageInfo.version;
    Environment.appBuildNumber = packageInfo.buildNumber;

    Bloc.observer = AppBlocObserver();
  }
}

class AppBlocObserver extends BlocObserver {
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log('Cubit error: $error');
    log('Cubit stackTrace: $stackTrace');
  }
}
