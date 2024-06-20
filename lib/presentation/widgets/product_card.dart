// TODO: Refactor this widget (done!)
import 'package:crafty_bay/presentation/screens/product_details_screen.dart';
import 'package:crafty_bay/presentation/widgets/wish_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/product.dart';
import '../utility/app_colors.dart';
import '../utility/assets_path.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key, required this.product
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() =>  ProductDetailsScreen(productId: product.id!,));
      },
      child: Card(
        surfaceTintColor: Colors.white,
        elevation: 3,
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
        ),
        child: SizedBox(
          width: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProductImage(),
              _buildProductOverview()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductOverview() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.title ?? '',
            maxLines: 1,
            style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 13,
                color: Colors.grey,
                fontWeight: FontWeight.w500),
          ),
          Wrap(
            spacing: 10,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
               Text(
                "\$${product.price}",
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor),
              ),
               Wrap(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 20,
                  ),
                  Text("${product.star}")
                ],
              ),
              //WishButton(showAddtoWishList: showAddtoWishList,)
            ],
          )
        ],
      ),
    );
  }

  Widget _buildProductImage() {
    return Container(
            width: 150,
            decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.15),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                )
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(product.image ?? ''),
            ),
          );
  }
}