import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mechanix_admin/controllers/dashboard_controller.dart';
import 'package:mechanix_admin/controllers/universal_controller.dart';
import 'package:mechanix_admin/helpers/custom_text.dart';
import 'package:mechanix_admin/helpers/profile_avatar.dart';
import 'package:mechanix_admin/helpers/storage_helper.dart';
import 'package:mechanix_admin/views/auth/login.dart';
import 'package:mechanix_admin/views/dashboard/right_side.dart';
import 'package:mechanix_admin/views/dashboard/side_menu.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  final DashboardController _controller = Get.put(DashboardController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _controller.tabController = TabController(
      initialIndex: 0,
      length: 9,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
     final UniversalController universalController = Get.put(UniversalController()); 
    return SafeArea(
      child: DefaultTabController(
        length: 9,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset('assets/images/home-bg.png', fit: BoxFit.fill),
            Scaffold(
              key: _scaffoldKey,
              backgroundColor: Colors.transparent,
              drawer: !context.isLandscape
                  ? Drawer(
                      child: SideMenuCard(
                        sideMenu: _controller.sideMenu,
                        scaffoldKey: _scaffoldKey,
                      ),
                    )
                  : null,
              body: Column(
                children: [
                  HomeAppbar(
                    sideMenu: _controller.sideMenu,
                    scaffoldKey: _scaffoldKey,
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color.fromRGBO(255, 220, 105, 0.4),
                            Color.fromRGBO(86, 127, 255, 0.4),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5.0,
                            spreadRadius: 5.0,
                          ),
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(22.0),
                          topRight: Radius.circular(22.0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (context.isLandscape)
                            SideMenuCard(
                              sideMenu: _controller.sideMenu,
                              scaffoldKey: _scaffoldKey,
                            ),
                          RightSideWidget(
                            pageController: _controller.pageController,
                            sideMenu: _controller.sideMenu,
                            tabController: _controller.tabController,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeAppbar extends StatelessWidget {
  final SideMenuController sideMenu;
  final GlobalKey<ScaffoldState> scaffoldKey;

  HomeAppbar({
    super.key,
    required this.sideMenu,
    required this.scaffoldKey,
  });

  final DashboardController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: context.height * 0.15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                context.isLandscape
                    ? Image.asset(
                        'assets/images/app-logo-white.png',
                        height: context.height * 0.08,
                        fit: BoxFit.cover,
                      )
                    : IconButton(
                        onPressed: () {
                          scaffoldKey.currentState?.openDrawer();
                        },
                        icon: const Icon(
                          Icons.menu_open_rounded,
                          size: 26.0,
                          color: Colors.white70,
                        ),
                      ),
                Obx(
                  () => CustomTextWidget(
                    text: controller.currentPage.value == 0
                        ? 'Admin Panel'
                        : controller.currentPage.value == 2
                            ? 'Registrations'
                            : controller.currentPage.value == 3
                                ? 'Users'
                                : controller.currentPage.value == 4
                                    ? 'Templates'
                                    : controller.currentPage.value == 5
                                        ? 'Equipments'
                                        : controller.currentPage.value == 6 
                                        ? 'Categories'
                                        : controller.currentPage.value == 8
                                        ? 'Profile'
                                        : '',
                    textColor: Colors.white,
                    fontSize: context.width > 800 ? 20.0 : 18.0,
                    fontWeight: FontWeight.w600,
                    maxLines: 2,
                  ),
                ),
              ],

//  : controller.currentPage.value == 7
//                                         ? 'Profile'
//                                         : '',
//                     textColor: Colors.white,

            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: context.isLandscape
                  ? Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade200,
                      ),
                      child: IconButton(
                        onPressed: () {
                          storage.remove('token');
                          storage.remove('user_info');
                          Get.delete<UniversalController>();
                          Get.delete<DashboardController>();
                          Get.offAll(() => const LoginScreen());
                        },
                        icon: const Icon(Icons.logout_rounded),
                      ),
                    )
                  : InkWell(
                      onTap: () => sideMenu.changePage(8),
                      child: const ProfileAvatar()),
            ),
          ],
        ));
  }
}
