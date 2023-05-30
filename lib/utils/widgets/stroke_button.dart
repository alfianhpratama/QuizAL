import 'package:flutter/material.dart';
import 'package:quizal/engine/themes.dart';

///
/// Created by alfianhpratama on 28/05/23
///

class StrokeButton extends StatelessWidget {
  final Function()? onClick;
  final String? title;
  final Widget? child;
  final bool isFitted;
  final TextStyle? textStyle;
  final Color? backgroundColor;

  const StrokeButton({
    Key? key,
    required this.onClick,
    this.title,
    this.child,
    this.textStyle,
    this.backgroundColor,
    this.isFitted = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = Text(title ?? 'Button', textAlign: TextAlign.center);
    if (isFitted) child = FittedBox(child: child);

    return ElevatedButton(
      onPressed: onClick,
      style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
            backgroundColor:
                const MaterialStatePropertyAll<Color>(Colors.transparent),
            shadowColor:
                const MaterialStatePropertyAll<Color>(Colors.transparent),
            foregroundColor:
                const MaterialStatePropertyAll<Color>(AppTheme.primary),
            side: const MaterialStatePropertyAll<BorderSide>(
              BorderSide(color: AppTheme.primary, width: 1.5),
            ),
          ),
      child: child,
    );
  }
}
