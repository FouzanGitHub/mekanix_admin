import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mechanix_admin/data/services/auth_service.dart';
import 'package:mechanix_admin/helpers/snackbar.dart';
import 'package:mechanix_admin/helpers/storage_helper.dart';
import 'package:mechanix_admin/views/auth/change_password.dart';
import 'package:mechanix_admin/views/auth/login.dart';
import 'package:mechanix_admin/views/auth/otp.dart';
import 'package:mechanix_admin/views/dashboard/dashboard.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var isTokenValid = true.obs;
  RxBool showPassword = false.obs;
  RxBool showConfirmPassword = false.obs;
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> changePasswordFormKey = GlobalKey<FormState>();

  // final UniversalController controller = Get.find();
  void saveUserInfo(Map<String, dynamic> userInfo) {
    storage.write('user_info', userInfo);
  }

  @override
  onInit() {
    emailController.text = storage.read('email') ?? '';
    passwordController.text = storage.read('password') ?? '';
    super.onInit();
  }

  //Calling Apis Methods.
  //loginUser
  Future<void> loginUser() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      isLoading.value = true;
      debugPrint('Email: ${emailController.text.trim()}');
      debugPrint('Password: ${passwordController.text.trim()}');

      try {
        Map<String, dynamic> response = await AuthService().loginUser(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        if (response['status'] == 'success') {
          MySnackBarsHelper.showMessage('Login Successfully');
          storage.write('token', response['token']);
          debugPrint('TokenAtStorage: ${storage.read('token')}');
           bool tokenValid = response['statusCode'] == 200;
          isTokenValid.value = tokenValid;
         print('IsTokenValid: ${isTokenValid.value}');
          saveUserInfo(response['user']);
          Get.offAll(() => const DashboardScreen(),
              transition: Transition.zoom);
          emailController.clear();
          passwordController.clear();
        } else {
          MySnackBarsHelper.showError(response['message']);
        }
      } catch (e) {
        MySnackBarsHelper.showError( 'Something went wrong, please try again.');
      } finally {
        isLoading.value = false;
      }
    }
  }

  //sendOtp
  Future<void> sendOtp({required bool verifyOtpForForgetPassword}) async {
    if (emailController.text.isNotEmpty) {
      isLoading.value = true;
      debugPrint('Email: ${emailController.text.trim()}');

      try {
        Map<String, dynamic> response = await AuthService().sendOtp(
          email: emailController.text.trim(),
        );

        if (response['status'] == 'success') {
          MySnackBarsHelper.showMessage('Please check your email, we have sent you an OTP');
          Get.off(() => OtpScreen(
                verifyOtpForForgetPassword: verifyOtpForForgetPassword,
                email: emailController.text.trim(),
              ));
        } else {
          MySnackBarsHelper.showError(response['message']);
        }
      } catch (e) {
        MySnackBarsHelper.showError( 'Something went wrong, please try again.');
      } finally {
        isLoading.value = false;
      }
    }
  }

  //verifyOtp
  Future<void> verifyOtp({required bool verifyOtpForForgetPassword}) async {
    if (emailController.text.isNotEmpty && otpController.text.isNotEmpty) {
      isLoading.value = true;
      debugPrint('Email: ${emailController.text.trim()}');
      debugPrint('OTP: ${otpController.text.trim()}');

      try {
        Map<String, dynamic> response = await AuthService().verifyOtp(
          email: emailController.text.trim(),
          otp: otpController.text.trim(),
        );

        if (response['status'] == 'success') {
          debugPrint('verifyOtpForForgetPassword: $verifyOtpForForgetPassword');
          debugPrint('VERIFY OTP API CALLED SUCCESSFULLY');
          MySnackBarsHelper.showMessage('OTP Verified Successfully');
          String token = response['data'][0]['token'];
        bool tokenValid = response['statusCode'] == 200;
          isTokenValid.value = tokenValid;
         print('IsTokenValid: ${isTokenValid.value}');
    
          debugPrint('TokenReceived: $token');
          storage.write('token', token);
          
          Get.offAll(() => const ChangePasswordScreen());
          // verifyOtpForForgetPassword
          //     ? Get.offAll(() => ChangePasswordScreen())
          //     : Get.offAll(() => const DashboardScreen());
          emailController.clear();
          otpController.clear();
          // clearAllControllers();
        } else {
          debugPrint('RESPONSE: ${response['message']}');
          MySnackBarsHelper.showError(response['message']);
        }
      } catch (e) {
        debugPrint('Something went wrong. ${e.toString()}');
        MySnackBarsHelper.showError( 'Something went wrong, please try again.');
      } finally {
        isLoading.value = false;
      }
    }
  }

  //changePassword
  Future<void> changePassword() async {
    if (passwordController.text.isNotEmpty ==
        confirmPasswordController.text.isNotEmpty) {
      isLoading.value = true;
      debugPrint('Password: ${passwordController.text.trim()}');
      debugPrint('ConfirmPassword: ${confirmPasswordController.text.trim()}');

      try {
        Map<String, dynamic> response = await AuthService().changePassword(
            password: passwordController.text.trim(),
            confirmPassword: confirmPasswordController.text.trim(),
            token: storage.read('token'));

        if (response['status'] == 'success') {
          MySnackBarsHelper.showMessage('Password Changed Successfully');
          passwordController.clear();
          confirmPasswordController.clear();
          Get.offAll(() => const LoginScreen());
        } else {
          MySnackBarsHelper.showError(response['message']);
        }
      } catch (e) {
        MySnackBarsHelper.showError( 'Something went wrong, please try again.');
      } finally {
        isLoading.value = false;
      }
    } else {
      MySnackBarsHelper.showError('Passwords does not match');
    }
  }

  void clearAllControllers() {
    fNameController.clear();
    lNameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    otpController.clear();
  }

  @override
  onClose() {
    fNameController.dispose();
    lNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  //Subscriptions
  // RxBool isSubscriptionPurchased = false.obs;
  // late SubscriptionType subscriptionType;
  // final Rx<SubscriptionType?> selectedSubscription = SubscriptionType.none.obs;
  //
  // void setSelectedSubscription(SubscriptionType subscriptionType) {
  //   selectedSubscription.value = subscriptionType;
  // }
  //
  // void updateUserSubscription() {
  //   subscriptionType = selectedSubscription.value ?? SubscriptionType.none;
  //   isSubscriptionPurchased.value = true;
  // }
}
