import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mechanix_admin/controllers/auth_controllers.dart';
import 'package:mechanix_admin/helpers/appcolors.dart';
import 'package:mechanix_admin/helpers/custom_button.dart';
import 'package:mechanix_admin/helpers/custom_text.dart';
import 'package:mechanix_admin/helpers/toast.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  final bool verifyOtpForForgetPassword;

  const OtpScreen(
      {super.key,
      required this.email,
      required this.verifyOtpForForgetPassword});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final AuthController _controller = Get.find();

  Color borderColor = Colors.black;
  Color errorColor = const Color.fromRGBO(255, 234, 238, 1);
  Color fillColor = Colors.white;
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 60,
    textStyle: const TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 22,
      color: Color.fromRGBO(30, 60, 87, 1),
    ),
    decoration: BoxDecoration(
      color: const Color.fromRGBO(222, 231, 240, .57),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.transparent),
    ),
  );

  bool _timerInProgress = true;
  int _start = 60;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer timer) {
      if (_start == 0) {
        setState(() {
          _timerInProgress = false;
        });
        timer.cancel();
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
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
                      horizontal: context.width * 0.02),
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
                                : context.width * 0.05),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: context.height * 0.1),
                              CustomTextWidget(
                                text: 'Check Your Email',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                              CustomTextWidget(
                                text:
                                    'A 6 digit code has been sent to ${widget.email}',
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.center,
                                fontStyle: FontStyle.italic,
                                maxLines: 4,
                              ),
                              SizedBox(height: context.height * 0.01),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Pinput(
                                  length: 6,
                                  keyboardType: TextInputType.text,
                                  controller: _controller.otpController,
                                  validator: (s) {
                                    return null;
                                  },
                                  errorTextStyle: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    color: Colors.redAccent,
                                  ),
                                  pinputAutovalidateMode:
                                      PinputAutovalidateMode.onSubmit,
                                  showCursor: true,
                                  defaultPinTheme: defaultPinTheme,
                                  focusedPinTheme: defaultPinTheme.copyWith(
                                    height: 68,
                                    width: 64,
                                    decoration:
                                        defaultPinTheme.decoration!.copyWith(
                                      border: Border.all(color: borderColor),
                                    ),
                                  ),
                                  errorPinTheme: defaultPinTheme.copyWith(
                                    decoration: BoxDecoration(
                                      color: errorColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onCompleted: (pin) {},
                                ),
                              ),
                              SizedBox(height: context.height * 0.02),
                              _timerInProgress
                                  ? CustomTextWidget(
                                      text: 'Resend OTP in $_start seconds')
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Column(
                                        children: [
                                          CustomTextWidget(
                                            text: 'Didn\'t receive the code?',
                                            fontSize: 14,
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              debugPrint('Resend OTP Clicked');
                                              _controller.sendOtp(
                                                  verifyOtpForForgetPassword:
                                                      false);
                                              setState(() {
                                                _timerInProgress = true;
                                                _start = 60;
                                              });
                                              _controller.otpController.clear();
                                              startTimer();
                                            },
                                            child: CustomTextWidget(
                                              text: 'Resend OTP',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                              SizedBox(height: context.height * 0.0),
                              //Button
                              Obx(
                                () => CustomButton(
                                  isLoading: _controller.isLoading.value,
                                  buttonText: 'Verify OTP',
                                  onTap: () {
                                    if (_controller
                                        .otpController.text.isEmpty) {
                                      ToastMessage.showToastMessage(
                                          message: 'Please Enter OTP',
                                          backgroundColor: Colors.red);
                                    } else {
                                      _controller.verifyOtp(
                                          verifyOtpForForgetPassword: widget
                                              .verifyOtpForForgetPassword);
                                    }
                                  },
                                  backgroundColor: AppColors.secondaryColor,
                                  textColor: Colors.white,
                                ),
                              ),
                              SizedBox(height: context.height * 0.02),
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
