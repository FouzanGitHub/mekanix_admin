// import 'package:flutter/material.dart';
// import 'package:mechanix_admin/helpers/custom_text.dart';
// import 'package:mechanix_admin/models/user_model.dart';
// import 'package:mechanix_admin/views/dashboard/subscription/user_plan_widget.dart';
//
// class SubscriptionTabbarView extends StatelessWidget {
//   final List<User> users;
//   const SubscriptionTabbarView({super.key, required this.users});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.transparent,
//       child: users.isEmpty
//           ? Center(child: CustomTextWidget(text: 'No Users found'))
//           : SingleChildScrollView(
//               child: Wrap(
//                 spacing: 8.0,
//                 runSpacing: 8.0,
//                 crossAxisAlignment: WrapCrossAlignment.center,
//                 alignment: WrapAlignment.center,
//                 children: users.asMap().entries.map((v) {
//                   final index = v.key;
//                   final user = v.value;
//                   return CustomUserPlanWidget(index: index, user: user);
//                 }).toList(),
//               ),
//             ),
//     );
//   }
// }
