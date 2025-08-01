import 'package:flutter/material.dart';
import 'package:itrip/ui/widget/login/bottom_arc_clipper.dart';

class HeaderArc extends StatelessWidget {
  const HeaderArc({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(clipper: BottomArcClipper(), child: child);
  }
}
