import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:quizal/utils/resources/assets.gen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

///
/// Created by alfianhpratama on 28/05/23
///

class ImageLoad extends StatelessWidget {
  final String imageUrl;
  final Widget? placeholder;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final EdgeInsets? padding;
  final bool isCircle;
  final double? radius;
  final ImageWidgetBuilder? imageBuilder;
  final Widget? errorWidget;

  const ImageLoad({
    Key? key,
    required this.imageUrl,
    this.placeholder,
    this.width,
    this.height,
    this.fit,
    this.padding,
    this.isCircle = false,
    this.radius,
    this.imageBuilder,
    this.errorWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget err = errorWidget ??
        Container(
          color: Colors.grey.withOpacity(0.1),
          padding: EdgeInsets.all(2.w),
          child: Center(child: Assets.icImageError.svg()),
        );

    Widget child = CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (ctx, url) {
        return placeholder ??
            Shimmer.fromColors(
              baseColor: Colors.black26,
              highlightColor: Colors.white30,
              child: Container(color: Colors.grey),
            );
      },
      width: width,
      height: height,
      fit: fit ?? BoxFit.cover,
      imageBuilder: imageBuilder,
      errorWidget: (ctx, url, error) {
        log('Get image error: $error');
        return err;
      },
    );

    if (imageUrl.isEmpty || imageUrl == 'null') {
      log('Failed get image from url: ${(imageUrl.isEmpty) ? 'empty url' : imageUrl}');
      child = err;
    }

    if (isCircle) {
      child = Container(
        decoration: const BoxDecoration(shape: BoxShape.circle),
        height: radius,
        width: radius,
        child: ClipOval(child: child),
      );
    }

    if (padding != null) {
      return Padding(padding: padding ?? EdgeInsets.zero, child: child);
    } else {
      return child;
    }
  }
}
