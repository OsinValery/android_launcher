import 'package:flutter/material.dart';
import 'package:platform_part/app_icon.dart' show AppIconView;

import '../logic/app.dart';

class LaunchEntityView extends StatelessWidget {
  const LaunchEntityView({super.key, required this.entity});

  static final Map<LaunchEntity, Widget> viewCashe = {};
  final LaunchEntity entity;

  @override
  Widget build(BuildContext context) {
    late Widget view;

    if (LaunchEntityView.viewCashe.containsKey(entity)) {
      view = LaunchEntityView.viewCashe[entity]!;
    } else {
      switch (entity) {
        case AppEntity():
          view = AppView(entity: entity as AppEntity);
          break;
        case DirEntity():
          view = DirView(entity: entity as DirEntity);
          break;
      }
      LaunchEntityView.viewCashe[entity] = view;
    }

    return SizedBox(
      height: 50,
      width: 50,
      child: view,
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key, required this.entity});

  final AppEntity entity;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.blue,
      child: AppIconView(appId: entity.appId),
    );
  }
}

class DirView extends StatelessWidget {
  const DirView({super.key, required this.entity});

  final DirEntity entity;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: const Text('dir'),
    );
  }
}
