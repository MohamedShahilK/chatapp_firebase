import 'package:get/get_rx/get_rx.dart';

// obs is from getx package, it is used to update the UI based on value of an observable variable (value.obs)

// We put variables related to its corresponding controller , we can also define these variables in controller folder.
// using this way to make code cleaner

class WelcomeState{
  var index = 0.obs;
}