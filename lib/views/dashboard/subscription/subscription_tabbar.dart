// import 'package:buttons_tabbar/buttons_tabbar.dart';
// import 'package:flutter/material.dart';
// import 'package:mechanix_admin/helpers/appcolors.dart';
// import 'package:mechanix_admin/helpers/custom_text.dart';
//
// class SubscriptionsTabbar extends StatelessWidget
//     implements PreferredSizeWidget {
//   final BuildContext context;
//   const SubscriptionsTabbar({super.key, required this.context});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       alignment: Alignment.center,
//       decoration: const BoxDecoration(color: Colors.transparent),
//       child: ButtonsTabBar(
//         // physics: const NeverScrollableScrollPhysics(),
//         backgroundColor: AppColors.blueTextColor,
//         unselectedBackgroundColor: Colors.grey[500],
//         tabs: [
//           buildTab(title: 'ALL', context: context),
//           buildTab(title: 'BASIC', context: context),
//           buildTab(title: 'STANDARD', context: context),
//           buildTab(title: 'GOLD', context: context),
//           buildTab(title: 'PREMIUM', context: context),
//         ],
//       ),
//     );
//   }
//
//   Tab buildTab({required BuildContext context, required String title}) {
//     return Tab(
//       child: SizedBox(
//         width: 100,
//         child: CustomTextWidget(
//           text: title,
//           fontSize: 14.0,
//           textAlign: TextAlign.center,
//           fontWeight: FontWeight.w500,
//           textColor: Colors.white,
//         ),
//       ),
//     );
//   }
//
//   @override
//   Size get preferredSize =>
//       Size.fromHeight(MediaQuery.of(context).size.height * 0.1);
// }
