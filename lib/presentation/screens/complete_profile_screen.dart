import 'package:crafty_bay/data/models/create_profile_model.dart';
import 'package:crafty_bay/presentation/screens/home_screen.dart';
import 'package:crafty_bay/presentation/state_holders/create_profile_controller.dart';
import 'package:crafty_bay/presentation/widgets/app_logo.dart';
import 'package:crafty_bay/presentation/widgets/centered_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/widgets/snack_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final TextEditingController _cusNameTEC = TextEditingController();
  final TextEditingController _cusAddressTEC = TextEditingController();
  final TextEditingController _cusCityTEC = TextEditingController();
  final TextEditingController _cusStateTEC = TextEditingController();
  final TextEditingController _cusPostCodeTEC = TextEditingController();
  final TextEditingController _cusCountryTEC = TextEditingController();
  final TextEditingController _cusPhoneTEC = TextEditingController();
  final TextEditingController _cusFaxTEC = TextEditingController();
  final TextEditingController _shipNameTEC = TextEditingController();
  final TextEditingController _shipAddressTEC = TextEditingController();
  final TextEditingController _shipCityTEC = TextEditingController();
  final TextEditingController _shipStateTEC = TextEditingController();
  final TextEditingController _shipPostCodeTEC = TextEditingController();
  final TextEditingController _shipCountryTEC = TextEditingController();
  final TextEditingController _shipPhoneTEC = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                  "Complete Profile",
                  style: textTheme.headlineLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  "Get started with us by providing your details",
                  style: textTheme.headlineSmall,
                ),
                const SizedBox(height: 24),
                _buildCompleteProfileForm(),
                const SizedBox(height: 16),
                GetBuilder<CreateProfileController>(
                    builder: (createProfileController) {
                  if (createProfileController.inProgress) {
                    return const CenteredCircularProgressIndicator();
                  }

                  return ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          CreateProfileModel createProfileModel =
                              CreateProfileModel(
                                  cusName: _cusNameTEC.text,
                                  cusCity: _cusCityTEC.text,
                                  cusState: _cusStateTEC.text,
                                  cusPostcode: _cusPostCodeTEC.text,
                                  cusCountry: _cusCountryTEC.text,
                                  cusPhone: _cusPhoneTEC.text,
                                  cusFax: _cusFaxTEC.text,
                                  cusAdd: _cusAddressTEC.text,
                                  shipName: _shipNameTEC.text,
                                  shipCity: _shipCityTEC.text,
                                  shipState: _shipStateTEC.text,
                                  shipPostcode: _shipPostCodeTEC.text,
                                  shipCountry: _shipCountryTEC.text,
                                  shipPhone: _shipPhoneTEC.text,
                                  shipAdd: _shipAddressTEC.text);

                          bool result = await createProfileController
                              .createProfile(createProfileModel);

                          if (result) {
                            if (mounted) {
                              showSnackMessage(
                                  context, "Profile Created Successfully");
                            }
                            Get.offAll(() => const HomeScreen());
                          } else {
                            if (mounted) {
                              showSnackMessage(context,
                                  createProfileController.errorMessage);
                            }
                          }
                        }
                      },
                      child: const Text("Complete"));
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompleteProfileForm() {
    final textTheme = Theme.of(context).textTheme;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text("Customer Details", style: textTheme.headlineLarge),
          const SizedBox(height: 16),
          TextFormField(
            controller: _cusNameTEC,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Enter your Full Name";
              }
              return null;
            },
            decoration: const InputDecoration(hintText: "Full Name"),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _cusCityTEC,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Enter your City";
              }
              return null;
            },
            decoration: const InputDecoration(hintText: "City"),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _cusStateTEC,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Enter your State";
              }
              return null;
            },
            decoration: const InputDecoration(hintText: "State"),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _cusPostCodeTEC,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Enter your Post Code";
              }
              return null;
            },
            decoration: const InputDecoration(hintText: "Post Code"),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _cusCountryTEC,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Enter your Country";
              }
              return null;
            },
            decoration: const InputDecoration(hintText: "Country"),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _cusPhoneTEC,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Enter your Phone";
              }
              return null;
            },
            decoration: const InputDecoration(hintText: "Phone"),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _cusFaxTEC,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Enter your FAX";
              }
              return null;
            },
            decoration: const InputDecoration(hintText: "FAX"),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _cusAddressTEC,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Enter your Full Address";
              }
              return null;
            },
            maxLines: 3,
            decoration: const InputDecoration(hintText: "Full Address"),
          ),
          const SizedBox(height: 16),
          Text("Shipping Details", style: textTheme.headlineLarge),
          const SizedBox(height: 16),
          TextFormField(
            controller: _shipNameTEC,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Enter your Full Name";
              }
              return null;
            },
            decoration: const InputDecoration(hintText: "Full Name"),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _shipCityTEC,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Enter your City";
              }
              return null;
            },
            decoration: const InputDecoration(hintText: "City"),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _shipStateTEC,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Enter your State";
              }
              return null;
            },
            decoration: const InputDecoration(hintText: "State"),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _shipPostCodeTEC,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Enter your Post Code";
              }
              return null;
            },
            decoration: const InputDecoration(hintText: "Post Code"),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _shipCountryTEC,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Enter your Country";
              }
              return null;
            },
            decoration: const InputDecoration(hintText: "Country"),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _shipPhoneTEC,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Enter your Phone";
              }
              return null;
            },
            decoration: const InputDecoration(hintText: "Phone"),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _shipAddressTEC,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Enter your Full Address";
              }
              return null;
            },
            maxLines: 3,
            decoration: const InputDecoration(hintText: "Full Address"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _cusNameTEC.dispose();
    _cusAddressTEC.dispose();
    _cusPhoneTEC.dispose();
    _cusCountryTEC.dispose();
    _cusPostCodeTEC.dispose();
    _cusStateTEC.dispose();
    _cusStateTEC.dispose();
    _cusFaxTEC.dispose();
    super.dispose();
  }
}
