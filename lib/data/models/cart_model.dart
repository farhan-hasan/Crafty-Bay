class CartModel {

  CartModel({
    required this.productId,
    required this.color,
    required this.size,
    required this.quantity,
  });

  final int productId;
  final String color;
  final String size;
  final int quantity;

  Map<String, dynamic> toJson() {
    return {
      "product_id": productId.toString(),
      "color": color,
      "size": size,
      "qty": quantity.toString()
    };
  }
}