import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodpanda_users_app/assistantMethods/cart_item_counter.dart';
import 'package:foodpanda_users_app/global/global.dart';
import 'package:foodpanda_users_app/splashScreen/splash_screen.dart';
import 'package:provider/provider.dart';

separateItemIDs() {
  List<String> separateItemIDsList = [], defaultItemList = [];
  int i = 0;
  defaultItemList = sharedPreferences!.getStringList("userCart")!;
  for (i; i < defaultItemList.length; i++) {
    String item = defaultItemList[i].toString();
    var pos = item.lastIndexOf(":");
    String getItemId = (pos != -1) ? item.substring(0, pos) : item;
    print("\nThis is itemID now = " + getItemId);
    separateItemIDsList.add(getItemId);
  }
  return separateItemIDsList;
}

separateItemQuantities() {
  List<int> separateItemQuantityList = [];
  List<String> defaultItemList = [];
  int i = 1;
  defaultItemList = sharedPreferences!.getStringList("userCart")!;
  for (i; i < defaultItemList.length; i++) {
    String item = defaultItemList[i].toString();

    List<String> listItemCharaters = item.split(":").toList();
    var quanNumber = int.parse(listItemCharaters[1].toString());
    print("\nThis is Quantit Number = " + quanNumber.toString());
    separateItemQuantityList.add(quanNumber);
  }
  return separateItemQuantityList;
}

addItemToCart(String? foodItemId, BuildContext context, int itemCounter) {
  List<String>? tempList = sharedPreferences!.getStringList("userCart");
  tempList!.add(foodItemId! + ":$itemCounter");

  FirebaseFirestore.instance
      .collection("users")
      .doc(firebaseAuth.currentUser!.uid)
      .update({"userCart": tempList}).then((value) {
    Fluttertoast.showToast(msg: "Item Added Successfully");
    sharedPreferences!.setStringList("userCart", tempList);

    //update the badge
    Provider.of<CartItemCounter>(context, listen: false)
        .displayCartListItemsNumber();
  });
}

clearCartNow(context) {
  sharedPreferences!.setStringList("userCart", ["garbageValue"]);
  List<String>? emptyList = sharedPreferences!.getStringList("userCart");

  FirebaseFirestore.instance
      .collection("users")
      .doc(firebaseAuth.currentUser!.uid)
      .update({"userCart": emptyList}).then((value) {
    sharedPreferences!.setStringList("userCart", emptyList!);
    Provider.of<CartItemCounter>(context, listen: false)
        .displayCartListItemsNumber();
  });
}
