import 'package:crafty_bay/data/models/create_review_model.dart';
import 'package:crafty_bay/presentation/state_holders/create_review_controller.dart';
import 'package:crafty_bay/presentation/widgets/centered_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/widgets/snack_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class CreateReviewScreen extends StatefulWidget {
  const CreateReviewScreen({super.key, required this.productId});

  final int productId;

  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  final TextEditingController _firstNameTEC = TextEditingController();
  final TextEditingController _lastNameTEC = TextEditingController();
  final TextEditingController _ratingTEC = TextEditingController();
  final TextEditingController _reviewTEC = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Review"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                _buildCompleteProfileForm(),
                const SizedBox(height: 16),
                GetBuilder<CreateReviewController>(
                    builder: (createReviewController) {
                  if (createReviewController.inProgress) {
                    return const CenteredCircularProgressIndicator();
                  }
                  return ElevatedButton(
                      onPressed: () async {
                        CreateReviewModel createReviewModel = CreateReviewModel(
                            description: _reviewTEC.text,
                            productId: widget.productId,
                            rating: int.parse(_ratingTEC.text));

                        if (_formKey.currentState!.validate()) {
                          bool result = await createReviewController
                              .createReview(createReviewModel);
                          if (result) {
                            showSnackMessage(
                                context, "Review added successfully");
                            if (mounted) {
                              Get.off(context);
                            } else {
                              showSnackMessage(
                                  context, createReviewController.errorMessage);
                            }
                          }
                        }
                      },
                      child: const Text("Submit"));
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompleteProfileForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _firstNameTEC,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Enter your First Name";
              }
              return null;
            },
            decoration: const InputDecoration(hintText: "First name"),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _lastNameTEC,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Enter your Last Name";
              }
              return null;
            },
            decoration: const InputDecoration(hintText: "Last name"),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _ratingTEC,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Enter your First Name";
              }
              if (!isNumeric(value!)) {
                return "Rating should be a number";
              }
              double v = double.parse(value);
              if (v > 5 || v < 1) {
                return "Enter a rating between 1 to 5";
              }
              return null;
            },
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: "Rating (1-5)"),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _reviewTEC,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Enter a review";
              }
              return null;
            },
            maxLines: 10,
            decoration: const InputDecoration(hintText: "Write Review"),
          ),
        ],
      ),
    );
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  @override
  void dispose() {
    _reviewTEC.dispose();
    _firstNameTEC.dispose();
    _lastNameTEC.dispose();
    _ratingTEC.dispose();
    super.dispose();
  }
}
