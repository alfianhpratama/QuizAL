import 'package:flutter/material.dart';

///
/// Created by alfianhpratama on 28/05/23
///

class SecondaryButton extends StatelessWidget {
  final Function()? onClick;
  final String? title;
  final Widget? child;
  final bool isFitted;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final OutlinedBorder? shape;

  const SecondaryButton({
    Key? key,
    required this.onClick,
    this.title,
    this.child,
    this.textStyle,
    this.backgroundColor,
    this.isFitted = false,
    this.shape,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = Text(title ?? 'Button', textAlign: TextAlign.center);
    if (isFitted) child = FittedBox(child: child);

    return ElevatedButton(
      onPressed: onClick,
      style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
            backgroundColor:
                const MaterialStatePropertyAll<Color>(Colors.white),
            foregroundColor:
                const MaterialStatePropertyAll<Color>(Colors.black87),
            shape: shape != null
                ? MaterialStatePropertyAll<OutlinedBorder>(shape!)
                : null,
          ),
      child: child,
    );
  }
}
