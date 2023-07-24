import 'package:launcher/logic/app.dart';

class AppState {
  static final _instance = AppState._();
  AppState._();
  factory AppState() => _instance;

  List<List<LaunchEntity>> launchPagesContent = List.generate(
    5,
    (index) => [],
  );
}
