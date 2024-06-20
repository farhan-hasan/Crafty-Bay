import 'package:crafty_bay/data/models/cart_item_model.dart';
import 'package:crafty_bay/data/models/cart_list_model.dart';
import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/network_caller/network_caller.dart';
import 'package:get/get.dart';

import '../../data/models/product.dart';
import '../../data/utility/urls.dart';

class CartListController extends GetxController {
  bool _inProgress = false;
  String _errorMessage = '';
  List<CartItemModel> _cartList = [];

  bool get inProgress => _inProgress;

  List<CartItemModel> get cartList => _cartList;

  String get errorMessage => _errorMessage;

  Future<bool> getCartList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.getCartList,
    );

    if (response.isSuccess) {
      _cartList = CartListModel.fromJson(response.responseData).cartList ?? [];
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();

    return isSuccess;
  }

  double get totalPrice {
    double total = 0;
    for (CartItemModel cartItem in _cartList) {
      total += (cartItem.qty!) *
          (double.tryParse(cartItem.product?.price ?? '0') ?? 0);
    }
    return total;
  }

  void changeProductQuantity (int cartId, int quantity) {
    _cartList.firstWhere((c) => c.id == cartId).qty = quantity;
    update();
  }

  void _deleteCartItem(int cartId) {
    _cartList.removeWhere((c) => c.id == cartId);
  }

  Future<bool> deleteCartItem (int cartId) async {
    // TODO: call api to remove the cart item
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.getWishList, // TODO: Change URL
    );

    if (response.isSuccess) {
      _deleteCartItem(cartId);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();

    return isSuccess;
  }
}
