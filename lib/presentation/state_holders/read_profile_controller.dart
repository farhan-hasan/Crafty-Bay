import 'dart:developer';

import 'package:crafty_bay/data/models/cart_item_model.dart';
import 'package:crafty_bay/data/models/cart_list_model.dart';
import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/models/read_profile_data.dart';
import 'package:crafty_bay/data/models/read_profile_model.dart';
import 'package:crafty_bay/data/network_caller/network_caller.dart';
import 'package:get/get.dart';

import '../../data/models/product.dart';
import '../../data/utility/urls.dart';

class ReadProfileController extends GetxController {
  bool _inProgress = false;
  String _errorMessage = '';

  bool get inProgress => _inProgress;

  late ReadProfileData? _profile;

  String get errorMessage => _errorMessage;

  ReadProfileData? get profile => _profile;

  Future<bool> readProfile() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.readProfile,
    );

    if (response.isSuccess) {
      _profile = ReadProfileModel.fromJson(response.responseData)
              .readProfileData;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();

    return isSuccess;
  }
}
