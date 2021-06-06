import 'package:flutter/widgets.dart';

import 'bubble_clipper.dart';

class Bubble extends StatelessWidget {
  const Bubble({Key? key, required this.child, required this.radius})
      : super(key: key);

  final Widget child;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BubbleClipper(
        radius: radius,
      ),
      child: child,
    );
  }
}
