import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/models/product_list_model.dart';
import 'package:crafty_bay/data/network_caller/network_caller.dart';
import 'package:get/get.dart';

import '../../data/models/product.dart';
import '../../data/utility/urls.dart';

class NewProductListController extends GetxController {
  bool _newProductInProgress = false;

  List<Product> _productList = [];

  String _errorMessage = '';

  bool get newProductInProgress => _newProductInProgress;

  List<Product> get newProductList => _productList;

  String get errorMessage => _errorMessage;

  Future<bool> getNewProductList() async {
    bool isSuccess = false;
    _newProductInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.productListByRemark('New'));
    if (response.isSuccess) {
      _productList =
          ProductListModel.fromJson(response.responseData).productList ?? [];
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _newProductInProgress = false;
    update();
    return isSuccess;
  }
}
