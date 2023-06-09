// import 'package:chatapp_firebase/pages/welcome/state.dart';
import 'package:chatapp_firebase/pages/welcome/index.dart';
import 'package:chatapp_firebase/routes/route_names.dart';
import 'package:chatapp_firebase/utils/config/config.dart';

import 'package:get/get.dart';

class WelcomeController extends GetxController {
  WelcomeController(); // Constructor
  
  final state = WelcomeState();

  changeIndexValue(int index) {
    state.index.value = index;
  }

  handleSignIn() async {
    await Config.to.saveAlreadyOpened();
    Get.offAndToNamed(AppRouteNames.signIn);
  }
}
