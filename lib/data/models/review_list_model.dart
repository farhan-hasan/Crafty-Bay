import 'package:crafty_bay/data/models/review_list_item.dart';

class ReviewListModel {
  String? msg;
  List<ReviewListItem>? reviewList;

  ReviewListModel({this.msg, this.reviewList});

  ReviewListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      reviewList = <ReviewListItem>[];
      json['data'].forEach((v) {
        reviewList!.add(ReviewListItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.reviewList != null) {
      data['data'] = this.reviewList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}




