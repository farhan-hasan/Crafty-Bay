import 'dart:async';
import 'dart:developer';

import 'package:crafty_bay/presentation/controllers/otp_counter_controller.dart';
import 'package:crafty_bay/presentation/screens/complete_profile_screen.dart';
import 'package:crafty_bay/presentation/screens/home_screen.dart';
import 'package:crafty_bay/presentation/screens/main_borrom_nav_bar_screen.dart';
import 'package:crafty_bay/presentation/state_holders/read_profile_controller.dart';
import 'package:crafty_bay/presentation/state_holders/verify_otp_controller.dart';
import 'package:crafty_bay/presentation/utility/app_colors.dart';
import 'package:crafty_bay/presentation/widgets/app_logo.dart';
import 'package:crafty_bay/presentation/widgets/centered_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/widgets/snack_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;

  const OtpVerificationScreen({super.key, required this.email});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpTEC = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final OtpCounterController _otpCounterController =
      Get.put(OtpCounterController());
  final ReadProfileController _readProfileController =
      Get.find<ReadProfileController>();

  // final OtpCounterController _otpCounterController =
  // Get.find<OtpCounterController>(); // lazyput not working

  @override
  void initState() {
    super.initState();
    startTimer();
    _otpCounterController.resetCounter();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const SizedBox(height: 100),
                const AppLogo(),
                const SizedBox(height: 16),
                Text(
                  "Enter OTP Code",
                  style: textTheme.headlineLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  "A 4 digit OTP code has been sent",
                  style: textTheme.headlineSmall,
                ),
                const SizedBox(height: 24),
                _buildPinField(),
                const SizedBox(height: 16),
                GetBuilder<VerifyOTPController>(builder: (verifyOTPController) {
                  if (verifyOTPController.inProgress) {
                    return const CenteredCircularProgressIndicator();
                  }

                  /// TODO: validate like email (done!)
                  return ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final result = await verifyOTPController.verifyOtp(
                              widget.email, _otpTEC.text);
                          if (result) {
                            // TODO: Pending in next 30th May, 2024 (done!)
                            // 1. If success, then call another api named "readProfile"
                            //   a. Create Read profile controller
                            // 2. check if data is "null" or not, if null then move to the
                            //    Complete profile screen, then move to home page
                            //    a. Create complete profile controller
                            // 3. Otherwise back to the home page

                            await _readProfileController.readProfile();
                            log(_readProfileController.readProfile().toString());
                            if(_readProfileController.profile == null) {
                              Get.to(() => const CompleteProfileScreen());
                            }
                            else {
                              Get.offAll(() => const MainBottomNavBarScreen());
                            }
                          } else {
                            if (mounted) {
                              showSnackMessage(
                                  context, verifyOTPController.errorMessage);
                            }
                          }
                        }
                      },
                      child: const Text("Next"));
                }),
                const SizedBox(height: 24),
                _buildResendCodeMessage(),
                //TextButton(onPressed: () {}, child: const Text("Resend Code"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void startTimer() {
    Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      if (_otpCounterController.isTimeUp == false) {
        _otpCounterController.decrementCounter();
      }
    });
  }

  Widget _buildResendCodeMessage() {
    //_otpCounterController.decrementCounter();
    return Column(
      children: [
        Obx(
          () => RichText(
              text: TextSpan(
                  style: const TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w500),
                  children: [
                const TextSpan(text: "This code will expire in "),
                // TODO: make this countdown (done!)
                TextSpan(
                    text: "${_otpCounterController.counter}s",
                    style: const TextStyle(color: AppColors.primaryColor))
              ])),
        ),
        Obx(() => TextButton(
            onPressed: _otpCounterController.counter == 0.obs
                ? () {
                    _otpCounterController.resetCounter();
                    setState(() {});
                    //startTimer();
                  }
                : null,
            child: const Text("Resend Code")))
      ],
    );
  }

  Widget _buildPinField() {
    return Form(
      key: _formKey,
      child: PinCodeTextField(
        validator: (String? value) {
          if (value?.isEmpty ?? true) {
            return "Enter OTP";
          }
          return null;
        },
        length: 6,
        obscureText: false,
        animationType: AnimationType.fade,
        keyboardType: TextInputType.number,
        pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 50,
            fieldWidth: 40,
            activeColor: AppColors.primaryColor,
            selectedColor: AppColors.primaryColor,
            activeFillColor: Colors.white,
            inactiveFillColor: Colors.transparent,
            selectedFillColor: Colors.white),
        animationDuration: const Duration(milliseconds: 300),
        enableActiveFill: true,
        controller: _otpTEC,
        appContext: context,
      ),
    );
  }

  @override
  void dispose() {
    _otpTEC.dispose();
    super.dispose();
  }
}
