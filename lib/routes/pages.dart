// import 'package:chatapp_firebase/pages/welcome/bindings.dart';
// import 'package:chatapp_firebase/pages/welcome/view.dart';
import '../pages/welcome/index.dart';

import 'package:chatapp_firebase/routes/route_names.dart';
import 'package:get/get.dart';

class AppPages {
  static const initial = AppRouteNames.initial;

  static final List<GetPage> routes = [
    // Welcome Page
    GetPage(
      name: AppRouteNames.initial,
      page: () => const WelcomePage(),
      binding: WelcomeBindings(),
    ),   
  ];
}