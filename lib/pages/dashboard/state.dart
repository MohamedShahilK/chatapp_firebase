import 'package:get/get.dart';

class DashBoardState {
  final _page = 0.obs;
  int get getPageIndex => _page.value;
  set setPageIndex(index) => _page.value = index;
}
