import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mechanix_admin/controllers/auth_controllers.dart';
import 'package:mechanix_admin/helpers/appcolors.dart';
import 'package:mechanix_admin/helpers/custom_button.dart';
import 'package:mechanix_admin/helpers/custom_text.dart';
import 'package:mechanix_admin/helpers/reusable_textfield.dart';
import 'package:mechanix_admin/helpers/toast.dart';
import 'package:mechanix_admin/helpers/validator.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.find();
    return SafeArea(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/auth-background.png', fit: BoxFit.cover),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: context.height * 0.05,
                        bottom: context.height * 0.05),
                    child: Image.asset('assets/images/app-logo.png',
                        height: context.height * 0.12, fit: BoxFit.cover),
                  ),
                ),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: context.height * 0.02,
                      horizontal: context.width * 0.04),
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                      boxShadow: const [
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
                      ]),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Opacity(
                          opacity: 0.3,
                          child: Image.asset(
                            'assets/images/gear.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: context.width > 700
                                ? context.width * 0.2
                                : context.width * 0.1),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomTextWidget(
                                text: 'Change your password',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                              CustomTextWidget(
                                text:
                                    'Enter password and confirm password to change your password',
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.center,
                                fontStyle: FontStyle.italic,
                                maxLines: 4,
                              ),
                              Form(
                                key: controller.changePasswordFormKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(height: context.height * 0.03),
                                    ReUsableTextField(
                                      controller: controller.passwordController,
                                      hintText: 'Password',
                                      prefixIcon: Icon(
                                        Icons.lock_open_rounded,
                                        color: AppColors.primaryColor,
                                      ),
                                      validator: (val) =>
                                          AppValidator.validatePassword(
                                              value: val),
                                    ),
                                    ReUsableTextField(
                                      controller:
                                          controller.confirmPasswordController,
                                      hintText: 'Confirm Password',
                                      prefixIcon: Icon(
                                        Icons.lock_open_rounded,
                                        color: AppColors.primaryColor,
                                      ),
                                      validator: (val) =>
                                          AppValidator.validatePassword(
                                              value: val),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: context.height * 0.03),
                              Obx(
                                () => CustomButton(
                                  isLoading: controller.isLoading.value,
                                  buttonText: 'Change Password',
                                  textColor: Colors.white,
                                  backgroundColor: AppColors.secondaryColor,
                                  onTap: () {
                                    if (controller
                                        .changePasswordFormKey.currentState!
                                        .validate()) {
                                      if (controller.passwordController.text
                                              .trim() !=
                                          controller
                                              .confirmPasswordController.text
                                              .trim()) {
                                        ToastMessage.showToastMessage(
                                            message:
                                                'Password and Confirm Password should be same',
                                            backgroundColor: Colors.red);
                                      } else {
                                        controller.changePassword();
                                      }
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
