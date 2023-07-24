sealed class LaunchEntity {
  LaunchEntity({this.dx = 0, this.dy = 0});
  double dx;
  double dy;
}

class AppEntity extends LaunchEntity {
  AppEntity({
    required this.appId,
    double dx = 0,
    double dy = 0,
  }) : super(dx: dx, dy: dy);

  String appId;
}

class DirEntity extends LaunchEntity {
  DirEntity({
    double dx = 0,
    double dy = 0,
  }) : super(dx: dx, dy: dy);

  List<AppEntity> content = [];
}
