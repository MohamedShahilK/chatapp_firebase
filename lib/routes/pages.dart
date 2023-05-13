// import 'package:chatapp_firebase/pages/welcome/bindings.dart';
// import 'package:chatapp_firebase/pages/welcome/view.dart';

import 'package:chatapp_firebase/pages/dashboard/bindings.dart';
import 'package:chatapp_firebase/pages/dashboard/view.dart';
import 'package:chatapp_firebase/pages/welcome/index.dart';
import 'package:chatapp_firebase/pages/dashboard/index.dart';

import 'package:chatapp_firebase/routes/route_names.dart';
import 'package:chatapp_firebase/utils/middleware/welcome_middleware.dart';
import 'package:get/get.dart';

class AppPages {
  static const initial = AppRouteNames.initial;

  static final List<GetPage> routes = [
    // Welcome Page
    GetPage(
      name: AppRouteNames.initial,
      page: () => const WelcomePage(),
      binding: WelcomeBinding(),
      middlewares: [
        WelcomeMiddleWare(priority: 1),
      ],
    ),

    // SignIn Page
    GetPage(
      name: AppRouteNames.signIn,
      page: () => const SignInPage(),
      binding: SignInBinding(),
    ),

    //
    GetPage(
      name: AppRouteNames.dashboard,
      page: () => const DashBoardPage(),
      binding: ApplicationBinding(),
    )
  ];
}
