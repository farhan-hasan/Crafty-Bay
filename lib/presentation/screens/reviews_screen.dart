import 'package:crafty_bay/presentation/screens/create_review_screen.dart';
import 'package:crafty_bay/presentation/state_holders/review_list_controller.dart';
import 'package:crafty_bay/presentation/widgets/centered_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/widgets/review_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utility/app_colors.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key, required this.productId});

  final int productId;

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<ReviewListController>().getReviewListList(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reviews"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
        child:
            GetBuilder<ReviewListController>(builder: (reviewListController) {
          if (reviewListController.inProgress) {
            return const CenteredCircularProgressIndicator();
          }

          return RefreshIndicator(
            onRefresh: () async {
              reviewListController.getReviewListList(widget.productId);
            },
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: reviewListController.reviewList.length,
                      itemBuilder: (context, index) {
                        return ReviewCard(
                          reviewListItem: reviewListController.reviewList[index],
                        );
                      }),
                ),
                _buildCheckoutWidget()
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildCheckoutWidget() {
    return GetBuilder<ReviewListController>(builder: (reviewListController) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.15),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Reviews (${reviewListController.reviewList.length})",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.70))),
            GestureDetector(
              onTap: () {
                Get.to(() => CreateReviewScreen(
                      productId: widget.productId,
                    ));
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(100)),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
