// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print, implementation_imports
import 'package:flutter/src/widgets/navigator.dart';
import 'package:get/get.dart';
import 'package:chatapp_firebase/routes/route_names.dart';
import 'package:chatapp_firebase/utils/config/config.dart';
import 'package:chatapp_firebase/utils/config/user_config.dart';

class WelcomeMiddleWare extends GetMiddleware {
  @override
  int? priority = 0;

  WelcomeMiddleWare({required this.priority});

  @override
  RouteSettings? redirect(String? route) {
    //
    print('Is opening first time :- ${Config.to.isFirstOpen}');

    // If App opens first time, isFirstOpen = true
    if (Config.to.isFirstOpen) {
      return null;
    }
    // isFirstOpen = false and isLogin = false
    else if (UserConfig.to.isLogin == false) {
      return const RouteSettings(name: AppRouteNames.signIn);
    } else {
      return const RouteSettings(name: AppRouteNames.dashboard);
    }
  }
}
