import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class AppIconView extends StatefulWidget {
  const AppIconView({super.key, required this.appId});

  static const _viewType = 'icon_view';
  final String appId;

  @override
  State<AppIconView> createState() => _AppIconViewState();
}

class _AppIconViewState extends State<AppIconView> {
  @override
  Widget build(BuildContext context) {
    return AndroidView(
      viewType: AppIconView._viewType,
      creationParams: widget.appId,
      layoutDirection: TextDirection.ltr,
      creationParamsCodec: const StandardMessageCodec(),
      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
        Factory(() => TapGestureRecognizer())
      },
    );

    return PlatformViewLink(
      surfaceFactory: (context, controller) {
        return AndroidViewSurface(
          controller: controller as AndroidViewController,
          hitTestBehavior: PlatformViewHitTestBehavior.opaque,
          gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
            Factory(() => TapGestureRecognizer())
          },
        );
      },
      onCreatePlatformView: (params) {
        return PlatformViewsService.initSurfaceAndroidView(
          id: params.id,
          viewType: params.viewType,
          onFocus: () => params.onFocusChanged(true),
          layoutDirection: TextDirection.ltr,
          creationParams: widget.appId,
          creationParamsCodec: const StandardMessageCodec(),
        )
          ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
          ..create();
      },
      viewType: AppIconView._viewType,
    );
  }
}
