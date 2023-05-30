import 'package:flutter/material.dart';
import 'package:quizal/engine/options.dart';

///
/// Created by alfianhpratama on 28/05/23
///

enum LoadingType { always, hidden, normal }

class ContainerStateHandler extends StatelessWidget {
  final Widget child;
  final Widget loading;
  final DataStateStatus status;
  final ErrorOptions? errorOptions;
  final EmptyOptions? emptyOptions;
  final LoadingType loadingType;
  final Widget? ready;
  final Widget? updated;
  final Widget? deleted;

  const ContainerStateHandler({
    Key? key,
    required this.child,
    required this.loading,
    required this.status,
    this.errorOptions,
    this.emptyOptions,
    this.loadingType = LoadingType.normal,
    this.ready,
    this.updated,
    this.deleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget body;
    switch (status) {
      case DataStateStatus.initial:
        switch (loadingType) {
          case LoadingType.always:
            body = ready ?? loading;
            break;
          case LoadingType.hidden:
            body = child;
            break;
          case LoadingType.normal:
            body = ready ?? loading;
            break;
        }
        break;
      case DataStateStatus.loading:
        switch (loadingType) {
          case LoadingType.always:
            body = loading;
            break;
          case LoadingType.hidden:
            body = child;
            break;
          case LoadingType.normal:
            body = child;
            break;
        }
        break;
      case DataStateStatus.success:
        body = child;
        break;
      case DataStateStatus.failed:
        body = _ErrorBuild(errorOptions: errorOptions);
        break;
      case DataStateStatus.empty:
        body = _EmptyBuild(emptyOptions: emptyOptions);
        break;
    }

    return body;
  }
}

class _ErrorBuild extends StatelessWidget {
  final ErrorOptions? errorOptions;

  const _ErrorBuild({Key? key, this.errorOptions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = Center(
      child: Text(
        errorOptions?.error ?? 'Error',
        style: Theme.of(context).textTheme.bodyMedium,
        textAlign: TextAlign.center,
      ),
    );

    if (errorOptions?.customError != null) child = errorOptions!.customError!;

    return child;
  }
}

class _EmptyBuild extends StatelessWidget {
  final EmptyOptions? emptyOptions;

  const _EmptyBuild({Key? key, this.emptyOptions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = Center(
      child: Text(
        emptyOptions?.empty ?? 'Empty Data',
        style: Theme.of(context).textTheme.bodyMedium,
        textAlign: TextAlign.center,
      ),
    );

    if (emptyOptions?.customEmpty != null) child = emptyOptions!.customEmpty!;

    return child;
  }
}
