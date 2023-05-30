import 'package:flutter/material.dart';

///
/// Created by alfianhpratama on 28/05/23
///

enum DataStateStatus { initial, loading, success, failed, empty }

class ErrorOptions {
  final String? error;
  final TextStyle? errorStyle;
  final String? errorDescriptions;
  final TextStyle? errorDescriptionsStyle;
  final Widget? customError;
  final Image? errorImage;
  final Function()? onRefresh;

  ErrorOptions({
    this.error,
    this.errorStyle,
    this.errorDescriptions,
    this.errorDescriptionsStyle,
    this.customError,
    this.errorImage,
    this.onRefresh,
  });
}

class EmptyOptions {
  final String? empty;
  final TextStyle? emptyStyle;
  final String? emptyDescriptions;
  final TextStyle? emptyDescriptionsStyle;
  final Image? emptyImage;
  final Widget? customEmpty;
  final EdgeInsets? emptyPadding;

  EmptyOptions({
    this.empty,
    this.emptyStyle,
    this.emptyDescriptions,
    this.emptyDescriptionsStyle,
    this.emptyImage,
    this.customEmpty,
    this.emptyPadding,
  });
}

extension DataStateStatusExt on DataStateStatus {
  bool get isInitial => this == DataStateStatus.initial;

  bool get isLoading => this == DataStateStatus.loading;

  bool get isSuccess => this == DataStateStatus.success;

  bool get isFailed => this == DataStateStatus.failed;

  bool get isEmpty => this == DataStateStatus.empty;
}
