import 'package:chatapp_firebase/firebase_options.dart';
import 'package:chatapp_firebase/utils/config/config.dart';
import 'package:chatapp_firebase/utils/config/user_config.dart';
import 'package:chatapp_firebase/utils/services/storage_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

Future<void> initialization() async {
  // Flutter
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Here we only need to initialize "ConfigStore" But we have to initialize "StorageServices" also
  // Because "ConfigStore" actually internally use "StorageServices"
  // So we need to initialize "StorageServices" first, then the "ConfigStore"

  // putAsync, because "StorageServices" class returns only after sharedPreferences is initialized, it is a Future function
  await Get.putAsync<StorageServices>(() => StorageServices().init());

  // Here "ConfigStore" class is directly used. So there is no need of waiting, no need of using putAsync
  Get.put<Config>(Config());

  // UserConfig is initialized
  Get.put<UserConfig>(UserConfig());
}
