import 'package:cloud_firestore/cloud_firestore.dart';

class Menus{
  String? menuID;
  String? menuInfo;
  String? menuTitle;
  Timestamp? publishedDate;
  String? sellerUID;
  String? status;
  String? thumbnailUrl;

  Menus({
    this.sellerUID,
    this.menuID,
    this.menuInfo,
    this.menuTitle,
    this.publishedDate,
    this.status,
    this.thumbnailUrl,
});

Menus.fromJson(Map<String,dynamic> json){
  menuID=json["menuID"];
  menuInfo=json["menuInfo"];
  menuTitle=json["menuTitle"];
  sellerUID=json["sellerUID"];
  publishedDate=json["publishedDate"];
  status=json["status"];
  thumbnailUrl=json["thumbnailUrl"];
}

  Map<String,dynamic> toJson(){
  final Map<String,dynamic> data = Map<String,dynamic>();

  data["menuID"]=this.menuID;
  data["menuTitle"]=this.menuTitle;
  data["menuInfo"]=this.menuInfo;
  data["sellerUID"]=this.sellerUID;
  data["publishedDate"]=this.publishedDate;
  data["status"]=this.status;
  data["thumbnailUrl"]=this.thumbnailUrl;
  return data;
  }

}