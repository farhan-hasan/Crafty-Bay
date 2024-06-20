import 'package:crafty_bay/data/models/review_list_user_model.dart';

class ReviewListItem {
  int? id;
  String? description;
  String? rating;
  int? customerId;
  int? productId;
  String? createdAt;
  String? updatedAt;
  ReviewListUserModel? reviewListUserModel;

  ReviewListItem(
      {this.id,
        this.description,
        this.rating,
        this.customerId,
        this.productId,
        this.createdAt,
        this.updatedAt,
        this.reviewListUserModel});

  ReviewListItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    rating = json['rating'];
    customerId = json['customer_id'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    reviewListUserModel =
    json['profile'] != null ? ReviewListUserModel.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['rating'] = this.rating;
    data['customer_id'] = this.customerId;
    data['product_id'] = this.productId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.reviewListUserModel != null) {
      data['profile'] = this.reviewListUserModel!.toJson();
    }
    return data;
  }
}