import 'package:flutter/material.dart';

import '../../data/models/review_list_item.dart';

class ReviewCard extends StatefulWidget {
  const ReviewCard({super.key, required this.reviewListItem});

  final ReviewListItem reviewListItem;

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 10,

              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey.withOpacity(0.15),
                  child: const Icon(Icons.person_outline_sharp),
                ),
                Text(
                  widget.reviewListItem.reviewListUserModel!.cusName ?? '',
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.70),
                      fontSize: 24,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w500),
                      maxLines: 1,
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              widget.reviewListItem.description ?? '',
              style: const TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
