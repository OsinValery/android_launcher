import 'package:flutter/services.dart';

class PlatformPart {
  factory PlatformPart() => _instance;
  static final _instance = PlatformPart._();
  PlatformPart._();

  final _appsListChannel = const MethodChannel("platform_part");

  Future<List>? getAppsList() async {
    var data = await _appsListChannel
        .invokeListMethod<Map<Object?, Object?>>('apps_list');
    List<Map<String, String?>> result = [];

    if (data != null) {
      result = data
          .map((e) => {
                for (var key in e.entries)
                  key.key as String: key.value as String?
              })
          .toList();
    }

    for (var el in result) {
      print(el);
    }
    print('end');

    return result;
  }
}
