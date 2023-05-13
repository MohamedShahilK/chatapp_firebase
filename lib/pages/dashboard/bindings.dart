import 'package:chatapp_firebase/pages/dashboard/controller.dart';
import 'package:get/get.dart';

class ApplicationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashBoardController>(() => DashBoardController());
  }
}
