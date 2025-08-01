import 'package:flutter/material.dart';

class ColoredSafeArea extends StatelessWidget {
  const ColoredSafeArea({super.key, required this.child, required this.color});
  final Widget child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: SafeArea(
        bottom: false,
        child: Container(color: Theme.of(context).canvasColor, child: child),
      ),
    );
  }
}
