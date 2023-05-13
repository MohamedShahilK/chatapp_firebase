import 'package:chatapp_firebase/pages/dashboard/state.dart';
import 'package:chatapp_firebase/utils/design_items/values/values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashBoardController extends GetxController {
  final state = DashBoardState();

  late final List<String> tabTitles;
  late final PageController pageController;
  late final List<BottomNavigationBarItem> bottomTabs;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: state.getPageIndex);
    tabTitles = ['Chat', 'Contact', 'Profile'];
    bottomTabs = [
      // Chat
      const BottomNavigationBarItem(
        icon: Icon(Icons.message, color: AppColors.thirdElementText),
        activeIcon: Icon(Icons.message, color: AppColors.secondaryElementText),
        label: 'Chat',
        backgroundColor: AppColors.primaryBackground,
      ),

      // Contact
      const BottomNavigationBarItem(
        icon: Icon(Icons.contact_page, color: AppColors.thirdElementText),
        activeIcon:
            Icon(Icons.contact_page, color: AppColors.secondaryElementText),
        label: 'Contact',
        backgroundColor: AppColors.primaryBackground,
      ),

      // Person
      const BottomNavigationBarItem(
        icon: Icon(Icons.person, color: AppColors.thirdElementText),
        activeIcon: Icon(Icons.person, color: AppColors.secondaryElementText),
        label: 'Person',
        backgroundColor: AppColors.primaryBackground,
      ),
    ];
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  // Handle Page Change function
  void handlePageChange(int index) {
    state.setPageIndex = index;
  }

  // Handle Bottom Nav Item Tap
  void handleTap(int index) {
    pageController.jumpToPage(index)
;  }
}
