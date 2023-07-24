import 'dart:math';

import 'package:flutter/material.dart';

class PageTurnAnimation extends StatelessWidget {
  const PageTurnAnimation({
    super.key,
    required this.value,
    required this.curPageWidget,
    required this.secondPageWidget,
    required this.direction,
  });

  final Widget curPageWidget;
  final Widget secondPageWidget;
  final double value;

  /// false  --->  ;  true  <---
  final bool direction;

  @override
  Widget build(BuildContext context) {
    var begin = direction ? const Offset(1, 0) : const Offset(-1, 0);
    var offset =
        Tween(end: Offset.zero, begin: begin).transform(sqrt(value.abs()));
    return Stack(
      children: [
        curPageWidget,
        FractionalTranslation(
            translation: offset,
            child: Container(
              color: Colors.yellow,
              child: secondPageWidget,
            )),
      ],
    );
  }
}
