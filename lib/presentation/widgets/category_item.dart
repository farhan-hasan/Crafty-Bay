import 'package:crafty_bay/presentation/screens/product_list_screen.dart';
import 'package:crafty_bay/presentation/widgets/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/category.dart';
import '../utility/app_colors.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductListScreen(
              categoryName: category.categoryName ?? '',
              categoryId: category.id!,
            ));
      },
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(16)),
              child: NetWorkImageWidget(
                url: category.categoryImg ?? '',
                height: 30,
                width: 30,
              )),
          const SizedBox(
            height: 8,
          ),
          Text(
            category.categoryName ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontSize: 18,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.4),
          )
        ],
      ),
    );
  }
}
