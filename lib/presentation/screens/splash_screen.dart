import 'package:crafty_bay/presentation/screens/email_verification_screen.dart';
import 'package:crafty_bay/presentation/screens/home_screen.dart';
import 'package:crafty_bay/presentation/screens/main_borrom_nav_bar_screen.dart';
import 'package:crafty_bay/presentation/state_holders/user_auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/app_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  void _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 1));
    await UserAuthController.getUserToken();
    Get.off(() => const MainBottomNavBarScreen());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          children: [
            Spacer(),
            AppLogo(),
            Spacer(),
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Version 1.0.0'),
            SizedBox(height: 16)
          ],
        ),
      ),
    );
  }
}
