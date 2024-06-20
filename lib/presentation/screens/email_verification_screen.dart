import 'package:crafty_bay/presentation/screens/otp_verification_screen.dart';
import 'package:crafty_bay/presentation/state_holders/verify_email_controller.dart';
import 'package:crafty_bay/presentation/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utility/constants.dart';
import '../widgets/snack_message.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _emailTEC = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  const AppLogo(),
                  const SizedBox(height: 16),
                  Text(
                    "Welcome back",
                    style: textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Please Enter Your Email Address",
                    style: textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return "Enter your email";
                      }
                      if (Constants.emailValidatorRegExp.hasMatch(value!) ==
                          false) {
                        return "Enter a valid email address";
                      }
                      return null;
                    },
                    controller: _emailTEC,
                    decoration: const InputDecoration(hintText: "Email"),
                  ),
                  const SizedBox(height: 16),
                  GetBuilder<VerifyEmailController>(
                    builder: (verifyEmailController) {
                      if(verifyEmailController.inProgress) {
                        return const CircularProgressIndicator();
                      }
                      return ElevatedButton(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              verifyEmailController
                                  .verifyEmail(_emailTEC.text.trim())
                                  .then((result) {
                                if (result) {
                                  Get.to(
                                        () => OtpVerificationScreen(
                                        email: _emailTEC.text),
                                  );
                                } else {
                                  showSnackMessage(
                                      context, verifyEmailController.errorMessage);
                                }
                              });
                            }
                          },
                          child: const Text("Next"));
                    }
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailTEC.dispose();
    super.dispose();
  }
}
