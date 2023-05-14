import 'dart:convert';

import 'package:chatapp_firebase/pages/Auth/models/user_login.dart';
import 'package:chatapp_firebase/utils/services/storage_services.dart';
import 'package:get/get.dart';

import '../design_items/values/values.dart';

class UserConfig extends GetxController {
  // important
  // it will generate an Instance each time you call Get.find().So along with that "onInit" function also will be call.
  static UserConfig get to => Get.find();

  // States
  final _isLogin = false.obs;
  String token = '';
  final _profile = UserLoginModel().obs;
  // States

  bool get isLogin => _isLogin.value;
  UserLoginModel get profile => _profile.value;
  bool get hasToken => token.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    token = StorageServices.to.getString(STORAGE_USER_TOKEN_KEY);
    var profileOffline = StorageServices.to.getString(STORAGE_USER_PROFILE_KEY);
    if (profileOffline.isNotEmpty) {
      _isLogin.value = true;
      _profile(UserLoginModel.fromJson(jsonDecode(profileOffline)));
    }
  }

  Future<void> saveProfile(UserLoginModel profile) async {
    _isLogin.value = true;
    // If you call jsonEncode() function without creating toJson() method. You will get an error:
    // Also do not change "toJson" to "toMap" or anything, also get error
    StorageServices.to.setString(STORAGE_USER_PROFILE_KEY, jsonEncode(profile));
    setToken(profile.accessToken!);
  }

  Future<void> setToken(String value) async {
    await StorageServices.to.setString(STORAGE_USER_TOKEN_KEY, value);
    token = value;
  }

  Future<String> getProfile() async {
    // if token is empty, return empty string
    if (token.isEmpty) return "";
    // otherwise, return this
    return StorageServices.to.getString(STORAGE_USER_PROFILE_KEY);
  }
}
