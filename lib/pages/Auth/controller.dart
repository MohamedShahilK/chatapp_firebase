// ignore_for_file: avoid_print

import 'package:chatapp_firebase/pages/Auth/models/user_firebase.dart';
import 'package:chatapp_firebase/pages/Auth/models/user_login.dart';
import 'package:chatapp_firebase/pages/Auth/state.dart';
import 'package:chatapp_firebase/routes/route_names.dart';
import 'package:chatapp_firebase/utils/config/user_config.dart';
import 'package:chatapp_firebase/utils/widgets/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    // Special settings are these for googlesignin, otherwise we might get error during signin
    // 'openId',
    'email',
    // 'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class SignInController extends GetxController {
  final state = SignInState();

  final db = FirebaseFirestore.instance;

  @override
  void onReady() {
    super.onReady();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently logged out');
      } else {
        print('User is currently logged in');
      }
    });
  }

  Future<void> handleSignIn() async {
    // Starts the interactive sign-in process

    // Step 1: Login with Google
    try {
      var user = await _googleSignIn.signIn();

      if (user != null) {
        //
        //
        // Actual Signin Process
        final googleAuthentication = await user.authentication;
        final credential = GoogleAuthProvider.credential(
          idToken: googleAuthentication.idToken,
          accessToken: googleAuthentication.accessToken,
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
        // Actual Signin Process
        //
        //

        // 
        // Remaining parts are to save login details in to database  (firestore database)
        // 
        // Step 2: Store user details from googleSignIn into variable
        String displayName = user.displayName ?? user.email;
        String email = user.email;
        String photoUrl = user.photoUrl ?? '';
        String id = user.id;

        // Step 3: Assign these variables to the UserLoginModel
        UserLoginModel userLoginModel = UserLoginModel(
            // displayName: displayName,
            // email: email,
            // photoUrl: photoUrl,
            // accessToken: id,
            );

        userLoginModel.displayName = displayName;
        userLoginModel.email = email;
        userLoginModel.photoUrl = photoUrl;
        userLoginModel.accessToken = id;

        // Step 4: Save UserLoginModel in sharedPreference for later use
        await UserConfig.to.saveProfile(userLoginModel);

        // Step 5: we have to check that firebase database has users or not
        var userbase = await db
            .collection("users")
            .withConverter(
              fromFirestore: UserDataModelFirebase
                  .fromFirestore, // model based on firebase
              toFirestore: (UserDataModelFirebase model, options) =>
                  model.toFirestore(),
            )
            .where("id", isEqualTo: id)
            .get();

        // Step 6: If User doesn't exist on FireBase, we add new User as UserDataModelFirebase instead of Map by using withConverter method.
        if (userbase.docs.isEmpty) {
          // Here we store in Firestore DataBase
          final data = UserDataModelFirebase(
            email: email,
            id: id,
            name: displayName,
            photourl: photoUrl,
            location: "",
            fcmtoken: "",
            // because here we adding to firebase, so in there datatime is in the form of timestamp
            addtime: Timestamp.now(),
          );

          await db
              .collection("users")
              .withConverter(
                fromFirestore: UserDataModelFirebase.fromFirestore,
                toFirestore: (UserDataModelFirebase model, options) =>
                    model.toFirestore(),
              )
              .add(data);
        }
        toastInfo(msg: "login success");
        Get.offAndToNamed(AppRouteNames.application);
      }
    } catch (e) {
      toastInfo(msg: "login error");
      print(e);
    }
  }
}
