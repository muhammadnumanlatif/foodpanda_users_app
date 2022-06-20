

import 'package:cloud_firestore/cloud_firestore.dart';

class Items {
  String? itemID;
  String? longDescription;
  String? menuID;
  int? price;
  Timestamp? publishedDate;
  String? sellerName;
  String? sellerUID;
  String? shortInfo;
  String? status;
  String? thumbnailUrl;
  String? title;

  Items({
    this.itemID,
    this.longDescription,
    this.menuID,
    this.title,
    this.thumbnailUrl,
    this.status,
    this.publishedDate,
    this.sellerUID,
    this.sellerName,
    this.price,
    this.shortInfo,
});

  Items.fromJson(Map<String,dynamic> json){
    itemID=json["itemID"];
    longDescription=json["longDescription"];
    menuID=json["menuID"];
    title=json["title"];
    thumbnailUrl=json["thumbnailUrl"];
    status=json["status"];
    publishedDate=json["publishedDate"];
    sellerUID=json["sellerUID"];
    sellerName=json["sellerName"];
    price=json["price"];
    shortInfo=json["shortInfo"];

  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = Map<String,dynamic>();

    data["shortInfo"]=this.shortInfo;
    data["price"]=this.price;
    data["sellerName"]=this.sellerName;
    data["sellerUID"]=this.sellerUID;
    data["publishedDate"]=this.publishedDate;
    data["status"]=this.status;
    data["thumbnailUrl"]=this.thumbnailUrl;
    data["title"]=this.title;
    data["menuID"]=this.menuID;
    data[""]=this.itemID;
    data[""]=this.longDescription;
    return data;
  }

}