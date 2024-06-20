import 'dart:developer';

import 'package:crafty_bay/presentation/state_holders/add_remove_in_wish_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/wish_list_controller.dart';
import 'package:crafty_bay/presentation/widgets/centered_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/widgets/snack_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../data/models/wish_list_item.dart';
import '../utility/app_colors.dart';

class WishButton extends StatefulWidget {
  const WishButton(
      {super.key, required this.productId});

  final int productId;

  @override
  State<WishButton> createState() => _WishButtonState();
}

class _WishButtonState extends State<WishButton> {
  bool isSelected = false;

  final AddRemoveInWishListController _addToWishListController =
      Get.find<AddRemoveInWishListController>();
  final WishListController _wishListController = Get.find<WishListController>();

  @override
  void initState() {
    super.initState();
    initIsSelected();
    log(isSelected.toString());
    log(widget.productId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddRemoveInWishListController>(
      builder: (addRemoveInWishListController) {
        if(addRemoveInWishListController.inProgress) {
          return const CenteredCircularProgressIndicator();
        }
        return InkWell(
          onTap: () async {
            if (isSelected) {
              bool result = await addRemoveInWishListController
                  .removeFromWishList(widget.productId);
              if (result) {
                if (mounted) {
                  showSnackMessage(
                      context, "Product removed from wish list successfully");
                }
              } else {
                if (mounted) {
                  showSnackMessage(
                      context, addRemoveInWishListController.errorMessage);
                }
              }
            } else {
              bool result =
                  await addRemoveInWishListController.addToWishList(widget.productId);
              if (result) {
                if (mounted) {
                  showSnackMessage(
                      context, "Product added ro wish list successfully");
                }
              } else {
                if (mounted) {
                  showSnackMessage(
                      context, addRemoveInWishListController.errorMessage);
                }
              }
            }
            toggleIsSelected();
          },
          child: _getIconButton(
            Icons.favorite_outline_rounded,
          ),
        );
      }
    );
  }

  void toggleIsSelected() {
    isSelected = !isSelected;
    setState(() {});
  }

  Future<void> initIsSelected() async {
    await _wishListController.getWishList();
    List<WishListItem> wishList = _wishListController.wishList;
    log(wishList.toString());
    for (WishListItem item in wishList) {
      log(item.productId.toString());
      if (item.productId == widget.productId) {
        isSelected = true;
        setState(() {});
        return;
      }
    }
    isSelected = false;
    setState(() {});
  }

  Widget _getIconButton(IconData icon) {
    return Card(
      color: AppColors.primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Icon(
          icon,
          size: 16,
          color: Colors.white,
        ),
      ),
    );
  }

  IconData _getIconData() {
    return isSelected ? Icons.favorite : Icons.favorite_outline_rounded;
  }
}
