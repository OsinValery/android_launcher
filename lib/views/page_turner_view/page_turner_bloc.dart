import 'package:launcher/default_bloc.dart';

class PageTurnerBloc extends DefaultBloc {
  PageTurnerBloc(context) : super(context);

  int curPage = 0;

  Map<String, dynamic> get curState => {
        'page': curPage,
      };

  @override
  void workEvent(Map<String, dynamic> data) {
    String type = data['type'];
    switch (type) {
      case "init":
        curPage = data['page'];
        break;

      case 'setPage':
        curPage = data['value'];

        break;

      default:
        super.workEvent(data);
        break;
    }
    notificationSink.add(curState);
  }
}
