import 'package:chatapp_firebase/firebase_options.dart';
import 'package:chatapp_firebase/routes/pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Important to run Screen Util Package 
    return ScreenUtilInit(
      builder: (context, child) => GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),

        // Definitely everything in this page get loaded even before our app starts to run the UI
        // As this initialRoute is loaded, then its binding (WelcomeBindings()) also would be loaded, so the controller(WelcomeController()) would get loadede
        // So at that time controller itself has some variables or things , then that also get loaded.
        initialRoute: AppPages.initial,

        getPages: AppPages.routes,
      ),
    );
  }
}
