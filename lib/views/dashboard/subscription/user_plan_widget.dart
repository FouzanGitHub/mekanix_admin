// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:mechanix_admin/controllers/universal_controller.dart';
// import 'package:mechanix_admin/helpers/appcolors.dart';
// import 'package:mechanix_admin/helpers/custom_button.dart';
// import 'package:mechanix_admin/helpers/custom_text.dart';
// import 'package:mechanix_admin/helpers/reusable_container.dart';
// import 'package:mechanix_admin/models/user_model.dart';
//
// enum UserAction { upgrade, pause, delete }
//
// class CustomUserPlanWidget extends StatelessWidget {
//   final User user;
//   final int index;
//
//   CustomUserPlanWidget({
//     super.key,
//     required this.user,
//     required this.index,
//   });
//   final UniversalController controller = Get.find();
//   @override
//   Widget build(BuildContext context) {
//     final DateFormat formatter = DateFormat('dd-MM-yyyy');
//     UserAction? selectedAction;
//
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: ReUsableContainer(
//         color: user.isActive ? Colors.white : Colors.white30,
//         showBackgroundShadow: user.isActive ? true : false,
//         width: 350,
//         child: Column(
//           children: [
//             ListTile(
//               leading: const CircleAvatar(
//                 backgroundImage: AssetImage('assets/images/user2.jpg'),
//               ),
//               title: CustomTextWidget(
//                 text: user.name ?? '',
//                 fontSize: 14.0,
//                 fontWeight: FontWeight.w500,
//               ),
//               subtitle: CustomTextWidget(
//                 text: user.email ?? '',
//                 fontSize: 12.0,
//                 fontWeight: FontWeight.w400,
//                 textColor: AppColors.lightTextColor,
//               ),
//               // trailing: IconButton(
//               //   icon: const Icon(Icons.delete),
//               //   onPressed: () {
//               //     controller.acceptedUsers.remove(user);
//               //   },
//               // ),
//               trailing:
//                   buildPopupMenuButton(context, selectedAction, controller),
//             ),
//             Wrap(
//               spacing: context.width * 0.1,
//               crossAxisAlignment: WrapCrossAlignment.center,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CustomTextWidget(
//                       text: 'Subscription Plan:',
//                       fontSize: 12.0,
//                       fontWeight: FontWeight.w500,
//                     ),
//                     CustomTextWidget(
//                       text: user.subscriptionType?.displayName ?? '',
//                       fontSize: 14.0,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     CustomTextWidget(
//                       text: formatter.format(user.startDate ?? DateTime.now()),
//                       fontSize: 12.0,
//                       fontWeight: FontWeight.w400,
//                       textColor: AppColors.lightTextColor,
//                     ),
//                     CustomTextWidget(
//                       text: formatter.format(user.endDate ?? DateTime.now()),
//                       fontSize: 12.0,
//                       fontWeight: FontWeight.w400,
//                       textColor: AppColors.lightTextColor,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             CustomButton(
//                 isLoading: false,
//                 backgroundColor: AppColors.primaryColor,
//                 width: 100,
//                 textColor: AppColors.textColor,
//                 buttonText: 'Upgrade',
//                 onTap: () {
//                   Get.to(() => UpdatePlanScreen(user: user));
//                 })
//           ],
//         ),
//       ),
//     );
//   }
//
//   PopupMenuButton<UserAction> buildPopupMenuButton(BuildContext context,
//       UserAction? selectedAction, UniversalController controller) {
//     return PopupMenuButton<UserAction>(
//       popUpAnimationStyle: AnimationStyle(
//         curve: Easing.emphasizedDecelerate,
//         duration: const Duration(seconds: 1),
//       ),
//       onSelected: (UserAction result) {
//         selectedAction = result;
//         // Handle the selected action
//         switch (selectedAction) {
//           case UserAction.upgrade:
//             // user.subscriptionType = SubscriptionType.gold;
//             // _openUserPlanDialog(context: context, index: index);
//             user.isActive = true;
//             controller.acceptedUsers.refresh();
//             break;
//           case UserAction.pause:
//             user.isActive = false;
//             controller.acceptedUsers.refresh();
//             break;
//           case UserAction.delete:
//             openDeleteUserDialog(
//                 context: context,
//                 index: index,
//                 user: user,
//                 controller: controller);
//             // MyErrorSnackbar(
//             //   title: 'Warning',
//             //   message: 'User was deleted successfully.',
//             // ).show(context);
//             break;
//           case null:
//             break;
//         }
//       },
//       itemBuilder: (BuildContext context) => <PopupMenuEntry<UserAction>>[
//         // PopupMenuItem<UserAction>(
//         //   value: UserAction.upgrade,
//         //   child:
//         //       CustomTextWidget(text: 'Upgrade', textColor: AppColors.textColor),
//         // ),
//         PopupMenuItem<UserAction>(
//           value: user.isActive ? UserAction.pause : UserAction.upgrade,
//           child: CustomTextWidget(
//               text: user.isActive ? 'Pause' : 'Resume',
//               textColor: AppColors.textColor),
//         ),
//         PopupMenuItem<UserAction>(
//           value: UserAction.delete,
//           child: CustomTextWidget(
//               text: 'Delete User', textColor: AppColors.textColor),
//         ),
//       ],
//     );
//   }
// }
//
// class UpdatePlanScreen extends StatefulWidget {
//   final User user;
//   const UpdatePlanScreen({super.key, required this.user});
//
//   @override
//   State<UpdatePlanScreen> createState() => _UpdatePlanScreenState();
// }
//
// class _UpdatePlanScreenState extends State<UpdatePlanScreen> {
//   final UniversalController controller = Get.find();
//   late SubscriptionType? selectedSubscription;
//
//   @override
//   void initState() {
//     super.initState();
//     selectedSubscription = widget.user.subscriptionType;
//   }
//
//   void setSelectedSubscription(SubscriptionType subscriptionType) {
//     setState(() {
//       selectedSubscription = subscriptionType;
//     });
//   }
//
//   void updateUserSubscription() {
//     setState(() {
//       widget.user.subscriptionType = selectedSubscription;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       fit: StackFit.expand,
//       children: [
//         Image.asset('assets/images/home-bg.png', fit: BoxFit.fill),
//         Scaffold(
//           backgroundColor: Colors.transparent,
//           body: Padding(
//             padding: EdgeInsets.only(top: context.height * 0.15),
//             child: Container(
//               height: context.height,
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.centerLeft,
//                   end: Alignment.centerRight,
//                   colors: [
//                     Color.fromRGBO(255, 220, 105, 0.4),
//                     Color.fromRGBO(86, 127, 255, 0.4),
//                   ],
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black26,
//                     blurRadius: 5.0,
//                     spreadRadius: 5.0,
//                   ),
//                   BoxShadow(
//                     color: Colors.white,
//                     offset: Offset(0.0, 0.0),
//                     blurRadius: 0.0,
//                     spreadRadius: 0.0,
//                   ),
//                 ],
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(22.0),
//                   topRight: Radius.circular(22.0),
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.only(top: context.height * 0.1),
//                         child: CustomTextWidget(
//                           text:
//                               'Upgrade ${widget.user.name} Plans for Enhanced Experience',
//                           fontSize: 16.0,
//                           fontWeight: FontWeight.w500,
//                           maxLines: 3,
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                       const SizedBox(height: 16.0),
//                       Wrap(
//                         alignment: WrapAlignment.center,
//                         children: [
//                           PlanContainer(
//                             plan: 'Basic Plan',
//                             duration: 'Monthly',
//                             isSelected:
//                                 selectedSubscription == SubscriptionType.basic,
//                             onSelected: setSelectedSubscription,
//                             gradient: const LinearGradient(
//                               colors: [Colors.white30, Colors.orangeAccent],
//                               begin: Alignment.topCenter,
//                               end: Alignment.bottomCenter,
//                             ),
//                           ),
//                           PlanContainer(
//                             plan: 'Standard Plan',
//                             duration: 'Quarterly',
//                             isSelected: selectedSubscription ==
//                                 SubscriptionType.standard,
//                             onSelected: setSelectedSubscription,
//                             gradient: const LinearGradient(
//                               colors: [Colors.white30, Colors.greenAccent],
//                               begin: Alignment.topCenter,
//                               end: Alignment.bottomCenter,
//                             ),
//                           ),
//                           PlanContainer(
//                             plan: 'Gold Plan',
//                             duration: 'Bi-Annual',
//                             isSelected:
//                                 selectedSubscription == SubscriptionType.gold,
//                             onSelected: setSelectedSubscription,
//                             gradient: const LinearGradient(
//                               colors: [Colors.white30, Colors.deepPurpleAccent],
//                               begin: Alignment.topCenter,
//                               end: Alignment.bottomCenter,
//                             ),
//                           ),
//                           PlanContainer(
//                             plan: 'Premium Plan',
//                             duration: 'Annually',
//                             isSelected: selectedSubscription ==
//                                 SubscriptionType.premium,
//                             onSelected: setSelectedSubscription,
//                             gradient: const LinearGradient(
//                               colors: [Colors.white30, Colors.yellowAccent],
//                               begin: Alignment.topCenter,
//                               end: Alignment.bottomCenter,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 16.0),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           CustomButton(
//                             isLoading: false,
//                             width: 120,
//                             backgroundColor: AppColors.primaryColor,
//                             buttonText: 'Update',
//                             textColor: AppColors.textColor,
//                             fontSize: 14.0,
//                             onTap: () {
//                               updateUserSubscription();
//                               controller.acceptedUsers.refresh();
//                               Get.back();
//                             },
//                           ),
//                           CustomButton(
//                             isLoading: false,
//                             backgroundColor: AppColors.secondaryColor,
//                             width: 120,
//                             textColor: AppColors.whiteTextColor,
//                             buttonText: 'Cancel',
//                             fontSize: 14.0,
//                             onTap: () {
//                               Get.back();
//                             },
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         Positioned(
//           left: 0,
//           top: 0,
//           child: IconButton(
//             onPressed: () => Get.back(),
//             icon: const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Icon(
//                 Icons.arrow_back,
//                 color: Colors.white70,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class PlanContainer extends StatelessWidget {
//   final String plan;
//   final String duration;
//   final bool isSelected;
//   final Gradient? gradient;
//   final Function(SubscriptionType) onSelected;
//
//   const PlanContainer({
//     super.key,
//     required this.plan,
//     required this.duration,
//     required this.isSelected,
//     required this.onSelected,
//     required this.gradient,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         // Notify the parent widget about the selection
//         onSelected(_getSubscriptionTypeFromPlan(plan));
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//           height: MediaQuery.of(context).size.height * 0.25,
//           width: 150,
//           decoration: BoxDecoration(
//             borderRadius: const BorderRadius.only(
//               bottomLeft: Radius.circular(12.0),
//               bottomRight: Radius.circular(12.0),
//             ),
//             border: Border.all(
//               color: isSelected ? Colors.black : Colors.transparent,
//               width: 1.0, // Border width
//             ),
//             gradient: gradient,
//           ),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 CustomTextWidget(
//                   text: duration,
//                   fontWeight: FontWeight.w600,
//                   fontSize: 16.0,
//                   decoration: TextDecoration.underline,
//                 ),
//                 const SizedBox(height: 20.0),
//                 CustomTextWidget(
//                   text: plan,
//                   fontWeight: FontWeight.w500,
//                 ),
//                 CustomTextWidget(
//                   text: 'Start: 12-05-2024',
//                   fontWeight: FontWeight.w300,
//                   textColor: AppColors.textColor,
//                   fontSize: 12.0,
//                 ),
//                 CustomTextWidget(
//                   text: 'End: 12-05-2025',
//                   fontWeight: FontWeight.w300,
//                   textColor: AppColors.textColor,
//                   fontSize: 12.0,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   SubscriptionType _getSubscriptionTypeFromPlan(String planName) {
//     switch (planName.toLowerCase()) {
//       case 'basic plan':
//         return SubscriptionType.basic;
//       case 'standard plan':
//         return SubscriptionType.standard;
//       case 'gold plan':
//         return SubscriptionType.gold;
//       case 'premium plan':
//         return SubscriptionType.premium;
//       default:
//         return SubscriptionType.all;
//     }
//   }
// }
//
