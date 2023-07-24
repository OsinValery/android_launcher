import 'package:flutter/material.dart';
import 'package:launcher/bloc_provider.dart';
import 'package:launcher/logic/app.dart';
import 'package:launcher/views/launch_entity_view.dart';
import 'package:launcher/views/launcher_page/launcher_page_bloc.dart';
import 'package:launcher/views/page_turner_view/page.dart';
import 'package:launcher/views/page_turner_view/page_turner.dart';
import 'package:launcher/views/page_turner_view/page_turner_bloc.dart';

class LauncherPage extends StatefulWidget {
  const LauncherPage({super.key});

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  late LauncherPageBloc bloc;

  late PageTurnerBloc secondaryBloc;

  @override
  void initState() {
    bloc = LauncherPageBloc(context);
    secondaryBloc = PageTurnerBloc(context);
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    secondaryBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.notificationStream,
      initialData: bloc.curState,
      builder: (context, snapshot) {
        Map<String, dynamic> data = snapshot.data as Map<String, dynamic>;

        List<LauncherPageView> content = [];
        var i = -1;

        for (List<LaunchEntity> page in data['pages']) {
          i += 1;
          content.add(
            LauncherPageView(
              key: Key(i.toString()),
              child: Stack(
                children: page.map((entity) {
                  var view = LaunchEntityView(entity: entity);
                  return Positioned(
                    left: entity.dx,
                    top: entity.dy,
                    child: LongPressDraggable(
                      onDraggableCanceled: (velocity, offset) => bloc.addEvent(
                          {'type': 'setPos', "pos": offset, "entity": entity}),
                      feedback: view,
                      child: view,
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        }

        return BlocProvider(
            bloc: secondaryBloc,
            child: PageTurnerWidget(content: content, initialPage: 0));
      },
    );
  }
}
