import 'dart:math';

import 'package:launcher/logic/app.dart';
import 'package:launcher/logic/app_state.dart';
import 'package:platform_part/platform_part.dart' show PlatformPart;

import '../../default_bloc.dart' show DefaultBloc;

class LauncherPageBloc extends DefaultBloc {
  LauncherPageBloc(context) : super(context) {
    PlatformPart().getAppsList()?.then((value) {
      var random = Random();
      for (var info in value) {
        appState.launchPagesContent[0].add(
          AppEntity(
            appId: info['id'],
            dx: random.nextInt(400).toDouble(),
            dy: random.nextInt(600).toDouble(),
          ),
        );
      }
      notificationSink.add(curState);
    });
  }

  final appState = AppState();

  Map<String, dynamic> get curState => {
        'pages': appState.launchPagesContent,
      };

  @override
  void workEvent(Map<String, dynamic> data) {
    switch (data['type']) {
      case "setPos":
        var entity = data['entity'];
        var pos = data['pos'];
        entity.dx = pos.dx;
        entity.dy = pos.dy;
        notificationSink.add(curState);
        break;
      default:
        super.workEvent(data);
        break;
    }
  }
}
