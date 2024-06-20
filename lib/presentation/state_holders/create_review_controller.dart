import 'package:crafty_bay/data/models/category.dart';
import 'package:crafty_bay/data/models/category_list_model.dart';
import 'package:crafty_bay/data/models/create_profile_model.dart';
import 'package:crafty_bay/data/models/create_review_model.dart';
import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/network_caller/network_caller.dart';
import 'package:get/get.dart';

import '../../data/models/cart_model.dart';
import '../../data/models/slider_data.dart';
import '../../data/utility/urls.dart';

class CreateReviewController extends GetxController {
  bool _inProgress = false;
  String _errorMessage = '';

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage;

  Future<bool> createReview(CreateReviewModel createReviewModel) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.createReview,
      body: createReviewModel.toJson(),
    );

    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();

    return isSuccess;
  }
}
