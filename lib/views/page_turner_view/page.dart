import 'package:flutter/material.dart';

class LauncherPageView extends StatelessWidget {
  const LauncherPageView({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withAlpha(1),
      child: Align(child: child),
    );
  }
}
