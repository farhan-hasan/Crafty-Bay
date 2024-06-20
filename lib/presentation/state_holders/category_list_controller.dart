import 'package:crafty_bay/data/models/category.dart';
import 'package:crafty_bay/data/models/category_list_model.dart';
import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/network_caller/network_caller.dart';
import 'package:get/get.dart';

import '../../data/models/slider_data.dart';
import '../../data/utility/urls.dart';

class CategoryListController extends GetxController {
  bool _inProgress = false;
  String _errorMessage = '';
  List<Category> _categoryList = [];

  bool get inProgress => _inProgress;

  List<Category> get categoryList => _categoryList;

  String get errorMessage => _errorMessage;

  Future<bool> getCategoryList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.categoryList);

    if (response.isSuccess) {
      _categoryList =
          CategoryListModel.fromJson(response.responseData).categoryList ?? [];
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();

    return isSuccess;
  }
}
