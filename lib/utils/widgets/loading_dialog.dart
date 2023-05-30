import 'package:flutter/material.dart';
import 'package:quizal/engine/base.dart';
import 'package:quizal/utils/helpers/notify.dart';
import 'package:sizer/sizer.dart';

///
/// Created by alfianhpratama on 28/05/23
///

class LoadingDialog {
  BuildContext? _dialogContext;

  LoadingDialog();

  void show({
    String title = "Memuat..",
    bool cancelable = true,
  }) async {
    BuildContext? ctx = MyApp.navigator.currentContext;

    if (ctx != null) {
      return await showDialog(
        context: ctx,
        barrierDismissible: cancelable,
        builder: (ctx) {
          _dialogContext = ctx;
          final circleSize = 2.w;

          const maxDigits = 5;
          List<String> titles = title.trim().split(' ');
          if (titles.length == 2 &&
              (titles[0].length > maxDigits || titles[1].length > maxDigits)) {
            title = titles.join("\n");
          } else if (titles.length > 2) {
            debugPrint('Loading title not valid');
            title = title;
          }

          return WillPopScope(
            onWillPop: () {
              if (!cancelable) ShowNotify.show(msg: "Mohon Tunggu..");
              return Future.value(cancelable);
            },
            child: Dialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(3.w),
                  ),
                  color: Theme.of(ctx).cardColor,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 3.w,
                  vertical: 4.w,
                ),
                margin: EdgeInsets.all(3.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: circleSize,
                      height: circleSize,
                      child: const CircularProgressIndicator(),
                    ),
                    SizedBox(height: 4.w),
                    Text(title, textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }

  void dismiss() async {
    try {
      if (_dialogContext != null && Navigator.of(_dialogContext!).canPop()) {
        Navigator.of(_dialogContext!).pop();
      }
    } catch (_) {}
  }
}
