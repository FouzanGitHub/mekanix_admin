// import 'package:easy_sidemenu/easy_sidemenu.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mechanix_admin/controllers/universal_controller.dart';
// import 'package:mechanix_admin/helpers/appcolors.dart';
// import 'package:mechanix_admin/helpers/custom_text.dart';
// import 'package:mechanix_admin/helpers/reusable_container.dart';
// import 'package:mechanix_admin/models/user_model.dart';
// import 'package:mechanix_admin/views/dashboard/subscription/subcription_tabbarview.dart';
// import 'package:mechanix_admin/views/dashboard/subscription/subscription_tabbar.dart';
//
// class SubscriptionsScreen extends StatelessWidget {
//   final SideMenuController sideMenu;
//   SubscriptionsScreen({super.key, required this.sideMenu});
//
//   final UniversalController controller = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: false,
//       onPopInvoked: (didPop) {
//         sideMenu.changePage(0);
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: DefaultTabController(
//           length: 5,
//           child: Container(
//             color: Colors.transparent,
//             padding: EdgeInsets.symmetric(horizontal: context.width * 0.04),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   width: double.infinity,
//                   child: ReUsableContainer(
//                     color: AppColors.primaryColor,
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 8.0, vertical: 8.0),
//                     child: CustomTextWidget(
//                       text: 'Users with Subscription Plans',
//                       fontSize: 16.0,
//                       fontWeight: FontWeight.w600,
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ),
//                 SubscriptionsTabbar(context: context),
//                 Expanded(
//                   child: TabBarView(
//                     children: [
//                       //It is throwing obx error.
//                       // Obx(() =>
//                       //     CustomTabbarView(users: controller.acceptedUsers)),
//                       Obx(
//                         () => SubscriptionTabbarView(
//                             users: controller.acceptedUsers.toList()),
//                       ),
//
//                       Obx(() => SubscriptionTabbarView(
//                           users: controller.acceptedUsers
//                               .where((user) =>
//                                   user.subscriptionType?.displayName == "Basic")
//                               .toList())),
//                       Obx(() => SubscriptionTabbarView(
//                           users: controller.acceptedUsers
//                               .where((user) =>
//                                   user.subscriptionType?.displayName ==
//                                   "Standard")
//                               .toList())),
//                       Obx(() => SubscriptionTabbarView(
//                           users: controller.acceptedUsers
//                               .where((user) =>
//                                   user.subscriptionType?.displayName == "Gold")
//                               .toList())),
//                       Obx(() => SubscriptionTabbarView(
//                           users: controller.acceptedUsers
//                               .where((user) =>
//                                   user.subscriptionType?.displayName ==
//                                   "Premium")
//                               .toList())),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
