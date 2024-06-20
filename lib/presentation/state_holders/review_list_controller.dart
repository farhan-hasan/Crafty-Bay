import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/models/product_list_model.dart';
import 'package:crafty_bay/data/models/review_list_item.dart';
import 'package:crafty_bay/data/models/review_list_model.dart';
import 'package:crafty_bay/data/models/wish_list_item.dart';
import 'package:crafty_bay/data/models/wish_list_model.dart';
import 'package:crafty_bay/data/network_caller/network_caller.dart';
import 'package:get/get.dart';

import '../../data/models/product.dart';
import '../../data/utility/urls.dart';

class ReviewListController extends GetxController {
  bool _inProgress = false;
  String _errorMessage = '';
  List<ReviewListItem> _reviewList = [];

  bool get inProgress => _inProgress;

  List<ReviewListItem> get reviewList => _reviewList;

  String get errorMessage => _errorMessage;

  Future<bool> getReviewListList(int productId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.reviewList(productId),
    );

    if (response.isSuccess) {
      _reviewList =
          ReviewListModel.fromJson(response.responseData).reviewList ?? [];
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();

    return isSuccess;
  }
}
