import 'package:chatapp_firebase/pages/dashboard/controller.dart';
import 'package:chatapp_firebase/utils/design_items/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashBoardPage extends GetView<DashBoardController> {
  const DashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _builPageView(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  // PageView
  Widget _builPageView() {
    return PageView(
      controller: controller.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        Center(child: Text('Chat')),
        Center(child: Text('Contact')),
        Center(child: Text('Person')),
      ],
      onPageChanged: (index) {
        // updates _page value in DashBoardState,which helps BottomNavigationBar to get current page index
        controller.handlePageChange(index);
      },
    );
  }

  // Bottom Navigation Bar
  Widget _bottomNavigationBar() {
    return Obx(
      () => BottomNavigationBar(
        items: controller.bottomTabs,
        currentIndex: controller.state.getPageIndex,
        type: BottomNavigationBarType.fixed,
        onTap: controller.handleTap,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        unselectedItemColor: AppColors.tabBarElement,
        selectedItemColor: AppColors.thirdElementText,
      ),
    );
  }
}
