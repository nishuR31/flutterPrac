import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:flutter/material.dart';

class CustomScrollBehaviour extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }

  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.mouse,
    PointerDeviceKind.stylus,
    PointerDeviceKind.trackpad,
    PointerDeviceKind.touch,
    PointerDeviceKind.invertedStylus,
    PointerDeviceKind.unknown,
  };
}
