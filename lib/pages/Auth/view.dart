import 'package:chatapp_firebase/utils/design_items/values/values.dart';
import 'package:chatapp_firebase/utils/widgets/custom_text_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../dashboard/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInPage extends GetView<SignInController> {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            _buildLogo(),
            _buildThridPartyLogin(),
          ],
        ),
      ),
    );
  }

  // Logo
  Widget _buildLogo() {
    return Container(
      width: 110.w,
      margin: EdgeInsets.only(top: 84.h),
      child: Column(
        children: [
          // Icon
          Container(
            width: 76.w,
            height: 76.w,
            margin: EdgeInsets.symmetric(horizontal: 15.w),
            child: Stack(
              children: [
                // Positioned(
                //   child: Container(
                //     height: 76,
                //     decoration: BoxDecoration(
                //       color: AppColor.primaryBackground,
                //       boxShadow: const [Shadows.primaryShadow],
                //       borderRadius: BorderRadius.circular(35.w),
                //     ),
                //   ),
                // ),

                // Chat Image
                Positioned(
                  width: 76.w,
                  height: 76.w,
                  child: Image.asset(
                    'assets/images/ic_launcher.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
          ),
          // Text
          Container(
            margin: EdgeInsets.symmetric(vertical: 15.h),
            child: Text(
              'Let\'s Chat',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.thirdElement,
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
                height: 1,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildThridPartyLogin() {
    return Container(
      width: 295.w,
      margin: EdgeInsets.only(bottom: 280.h),
      child: Column(
        children: [
          // Text
          Text(
            'Sign in with social networks',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.primaryText,
              fontWeight: FontWeight.w400,
              fontSize: 16.sp,
            ),
          ),

          // SignIn Button
          Padding(
            padding: EdgeInsets.only(top: 30.h, left: 50.w, right: 50.w),
            child: btnFlatButtonWidget(
                onPressed: () {
                  controller.handleSignIn();
                },
                width: 200.w,
                height: 55.h,
                title: 'Google Login'),
          )
        ],
      ),
    );
  }
}
