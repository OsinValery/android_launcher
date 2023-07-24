import 'package:flutter/material.dart';

import 'default_bloc.dart';

class BlocProvider extends InheritedWidget {
  const BlocProvider({
    required child,
    Key? key,
    required this.bloc,
  }) : super(child: child, key: key);

  final DefaultBloc bloc;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

  static DefaultBloc of(BuildContext context) =>
      context.getInheritedWidgetOfExactType<BlocProvider>()!.bloc;

  static DefaultBloc? mayBeOf(BuildContext context) =>
      context.getInheritedWidgetOfExactType<BlocProvider>()?.bloc;
}
