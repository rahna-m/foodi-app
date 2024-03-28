import 'package:cloud_firestore/cloud_firestore.dart';

class Menus {
  String? menuTitle;
  String? menuID;
  String? sellerUID;
  String? menuInfo;
  String? status;
  String? thumbnailUrl;
  Timestamp? publishedDate;

  Menus({
    this.menuID,
    this.sellerUID,
    this.menuTitle,
    this.menuInfo,
    this.publishedDate,
    this.status,
    this.thumbnailUrl
  });

  Menus.fromJson(Map<String, dynamic> json){
    menuID = json['menuID'];
    sellerUID = json['sellerUID'];
    menuTitle = json['menuTitle'];
    menuInfo = json['menuInfo'];
    status = json['status'];
    thumbnailUrl = json['thumbnailUrl'];
    publishedDate = json['publishedDate'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['menuID'] = menuID;
    data['sellerUID'] = sellerUID;
    data['menuTitle'] = menuTitle;
    data['menuInfo'] = menuInfo;
    data['status'] = status;
    data['thumbnailUrl'] = thumbnailUrl;
    data['publishedDate'] = publishedDate;
    return data;
  }
}