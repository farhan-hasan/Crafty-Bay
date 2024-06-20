import 'package:crafty_bay/data/models/read_profile_data.dart';

class ReadProfileModel {
  String? msg;
  ReadProfileData? readProfileData;

  ReadProfileModel({this.msg, this.readProfileData});

  ReadProfileModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    readProfileData =
        json['data'] != null ? ReadProfileData.fromJson(json['data']) : null;
  }
}
