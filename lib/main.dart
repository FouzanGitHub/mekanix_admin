import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mechanix_admin/helpers/storage_helper.dart';
import 'package:mechanix_admin/views/auth/login.dart';
import 'package:mechanix_admin/views/dashboard/dashboard.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Mekanix Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: storage.read('token') != null
          ? const DashboardScreen()
          : const LoginScreen(),
    );
  }
}
