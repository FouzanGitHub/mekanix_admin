import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mechanix_admin/controllers/auth_controllers.dart';
import 'package:mechanix_admin/helpers/appcolors.dart';
import 'package:mechanix_admin/helpers/custom_button.dart';
import 'package:mechanix_admin/helpers/custom_text.dart';
import 'package:mechanix_admin/helpers/reusable_textfield.dart';
import 'package:mechanix_admin/helpers/validator.dart';
import 'package:mechanix_admin/views/auth/forget_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController _controller = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                        child: Image.asset(
                          'assets/images/gear.png',
                          fit: BoxFit.fitWidth,
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
                              SizedBox(height: context.height * 0.1),
                              CustomTextWidget(
                                text: 'Login to your Account',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                              CustomTextWidget(
                                text: 'Please enter your Email & Password.',
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.center,
                                fontStyle: FontStyle.italic,
                                maxLines: 4,
                              ),
                              Form(
                                key: _formKey,
                                child: AutofillGroup(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SizedBox(height: context.height * 0.03),
                                      ReUsableTextField(
                                        controller: _controller.emailController,
                                        hintText: 'Email',
                                        autofillHints: const [
                                          AutofillHints.email
                                        ],
                                        prefixIcon: Icon(
                                          Icons.email_outlined,
                                          color: AppColors.primaryColor,
                                        ),
                                        validator: (val) =>
                                            AppValidator.validateEmail(
                                                value: val),
                                      ),
                                      Obx(
                                        () => ReUsableTextField(
                                          controller:
                                              _controller.passwordController,
                                          hintText: 'Password',
                                          autofillHints: const [
                                            AutofillHints.password
                                          ],
                                          prefixIcon: Icon(
                                            Icons.lock_open_rounded,
                                            color: AppColors.primaryColor,
                                          ),
                                          obscureText:
                                              _controller.showPassword.value
                                                  ? false
                                                  : true,
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              _controller.showPassword.value =
                                                  !_controller
                                                      .showPassword.value;
                                            },
                                            icon: _controller.showPassword.value
                                                ? const Icon(
                                                    CupertinoIcons.eye_fill)
                                                : const Icon(
                                                    CupertinoIcons
                                                        .eye_slash_fill,
                                                  ),
                                          ),
                                          validator: (val) =>
                                              AppValidator.validatePassword(
                                                  value: val),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () => Get.to(
                                          () => ForgetPasswordScreen(),
                                          transition: Transition.size,
                                          duration: const Duration(seconds: 1),
                                        ),
                                        child: CustomTextWidget(
                                          text: 'Forget Password?',
                                          fontSize: 12.0,
                                          textAlign: TextAlign.center,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: context.height * 0.03),
                              Obx(
                                () => CustomButton(
                                  isLoading: _controller.isLoading.value,
                                  textColor: AppColors.whiteTextColor,
                                  backgroundColor: AppColors.secondaryColor,
                                  buttonText: 'Login',
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      _controller.loginUser();
                                    }
                                  },
                                ),
                              ),
                              // SizedBox(height: context.height * 0.02),
                              // Center(
                              //   child: GestureDetector(
                              //     onTap: () {
                              //       Get.to(
                              //         () => const SignupScreen(),
                              //         transition: Transition.size,
                              //         duration: const Duration(seconds: 1),
                              //       );
                              //     },
                              //     child: Text.rich(
                              //       TextSpan(
                              //         text: 'If you don’t have any account? ',
                              //         style: const TextStyle(
                              //             fontFamily: 'Poppins',
                              //             fontWeight: FontWeight.w500,
                              //             fontSize: 12.0),
                              //         children: [
                              //           TextSpan(
                              //             text: 'Signup',
                              //             style: TextStyle(
                              //                 color: AppColors.blueTextColor,
                              //                 fontFamily: 'Poppins',
                              //                 fontWeight: FontWeight.w500,
                              //                 fontSize: 14.0),
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // ),
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
