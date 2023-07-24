import 'package:flutter/material.dart';
import 'package:launcher/bloc_provider.dart';
import 'package:launcher/views/page_turner_view/page_turn_animation.dart';
import 'package:launcher/views/page_turner_view/page_turner_bloc.dart';

import 'page.dart';

class PageTurnerWidget extends StatefulWidget {
  const PageTurnerWidget({
    super.key,
    required this.content,
    required this.initialPage,
  });

  final List<LauncherPageView> content;
  final int initialPage;

  @override
  State<PageTurnerWidget> createState() => _PageTurnerWidgetState();
}

class _PageTurnerWidgetState extends State<PageTurnerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  double? widgetWidth;
  int curPage = 0;
  int maxPages = 0;

  double curValue = 0;
  Offset? startPoint;
  bool direction = false;

  late PageTurnerBloc? bloc;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    maxPages = widget.content.length;
    curPage = widget.initialPage < maxPages ? widget.initialPage : 0;
    _controller.addListener(() {
      setState(() => curValue = _controller.value);
    });

    Future.delayed(
      const Duration(milliseconds: 20),
      () {
        bloc = BlocProvider.of(context) as PageTurnerBloc?;
        bloc?.notificationStream.listen((event) {
          curPage = event['page'];
          curValue = 0;
          setState(() {});
        });
      },
    );
  }

  void resolvePageTurning() {
    double pageTransition = 0;
    if (curValue > 0.4) pageTransition = 1;
    if (curValue < -0.4) pageTransition = -1;
    _controller.value = curValue;

    _controller
        .animateTo(
          pageTransition,
          duration: const Duration(microseconds: 259),
        )
        .then(
          (value) => bloc?.addEvent({
            'type': 'setPage',
            'value': (curPage + pageTransition.truncate()) % maxPages,
          }),
        );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widgetWidth ??= MediaQuery.of(context).size.width;
    var secondPage = curPage + (direction ? 1 : -1);

    return GestureDetector(
      onPanDown: (details) {
        _controller.stop();
        startPoint = details.localPosition;
      },
      onPanEnd: (details) => resolvePageTurning(),
      onPanUpdate: (details) {
        setState(() {
          if (startPoint != null && widgetWidth != null) {
            curValue =
                (startPoint!.dx - details.localPosition.dx) / widgetWidth!;
            direction = (curValue == 0) ? direction : curValue > 0;
          }
        });
      },
      child: Stack(
        children: [
          for (var view in widget.content) Opacity(opacity: 0, child: view),
          PageTurnAnimation(
            curPageWidget: widget.content[curPage],
            secondPageWidget: widget.content[secondPage % maxPages],
            direction: direction,
            value: curValue,
          )
        ],
      ),
    );
  }
}
