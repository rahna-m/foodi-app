import 'package:cloud_firestore/cloud_firestore.dart';

class Items {
  String? sellerUID;
  String? menuID;
  String? itemID;
  String? title;
  String? shortInfo;
  String? status;
  String? thumbnailUrl;
  Timestamp? publishedDate;
  String? longDescription;
  int? price;

  Items(
      {this.sellerUID,
      this.menuID,
      this.itemID,
      this.title,
      this.shortInfo,
      this.publishedDate,
      this.status,
      this.thumbnailUrl,
      this.longDescription,
      this.price});

  Items.fromJson(Map<String, dynamic> json) {
    sellerUID = json['sellerUID'];
    menuID = json['menuID'];
    itemID = json['itemID'];
    title = json['title'];
    shortInfo = json['shortInfo'];
    status = json['status'];
    thumbnailUrl = json['thumbnailUrl'];
    publishedDate = json['publishedDate'];
    longDescription = json['longDescription'];
    price = int.parse(json['price']) ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['sellerUID'] = sellerUID;
    data['menuID'] = menuID;
    data['itemID'] = itemID;
    data['title'] = title;
    data['shortInfo'] = shortInfo;
    data['status'] = status;
    data['thumbnailUrl'] = thumbnailUrl;
    data['publishedDate'] = publishedDate;
    data['longDescription'] = longDescription;
    data['price'] = price;
    return data;
  }
}
