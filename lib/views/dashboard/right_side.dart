import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:mechanix_admin/views/dashboard/home.dart';
import 'package:mechanix_admin/views/dashboard/profile_section.dart';
import 'package:mechanix_admin/views/dashboard/registrations.dart';
import 'package:mechanix_admin/views/dashboard/users.dart';

import 'tasks/task.dart';

class RightSideWidget extends StatelessWidget {
  const RightSideWidget({
    super.key,
    required this.pageController,
    required this.sideMenu,
    required this.tabController,
  });

  final PageController pageController;
  final SideMenuController sideMenu;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        // controller: pageController,
        controller: tabController,
        children: [
          HomeSection(sideMenu: sideMenu),

          const SizedBox.shrink(), //Drawer
          RegistrationScreen(sideMenu: sideMenu),
        
          UserScreen(sideMenu: sideMenu),
          TaskScreen(sideMenu: sideMenu),
          // SubscriptionsScreen(sideMenu: sideMenu),
          const SizedBox.shrink(), //Drawer
          ProfileSection(sideMenu: sideMenu),
        ],
      ),
    );
  }
}
