import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quizal/utils/helpers/notify.dart';
import 'package:quizal/utils/widgets/loading_dialog.dart';
import 'package:share_plus/share_plus.dart';

///
/// Created by alfianhpratama on 30/05/23
///

class Rendering {
  static void share(GlobalKey resultKey) async {
    final loadingDialog = LoadingDialog();
    loadingDialog.show(title: 'Menyiapkan gambar');

    String fileName = 'QuizAL_${DateTime.now().toIso8601String()}.png';
    File? result = await captureWidget(resultKey, fileName);

    if (result != null) {
      await Share.shareXFiles([XFile(result.path)], subject: "Quiz AL");
      loadingDialog.dismiss();
    } else {
      Future.delayed(const Duration(milliseconds: 500), () {
        loadingDialog.dismiss();
        ShowNotify.error(msg: 'Opps! Terjadi kesalahan dalam rendering');
        log('error');
      });
    }
  }

  static Future<File?> captureWidget(
    GlobalKey resultKey,
    String fileName,
  ) async {
    try {
      RenderRepaintBoundary? boundary = resultKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary?;
      ui.Image image = await boundary!.toImage(pixelRatio: 2);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      final directory = (await getTemporaryDirectory()).path;
      String path = '$directory/$fileName';
      log('path is $path');
      File result = File(path);
      await result.writeAsBytes(pngBytes).then((onValue) {});
      log('rendering done');
      return result;
    } catch (e) {
      log('error');
      log(e.toString());
      return null;
    }
  }
}
