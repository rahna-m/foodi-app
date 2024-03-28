import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodii_users_app/assistantMethods/cart_item_counter.dart';
import 'package:foodii_users_app/global/global.dart';
import 'package:provider/provider.dart';


seperateOrderItemIDs(orderIDs) {
  List<String> separeteItemIdsList = [], defaultItemList = [];
  int i = 0;
  defaultItemList = List<String>.from(orderIDs);

  for (i; i < defaultItemList.length; i++) {
     // 56557657:7
    String item = defaultItemList[i].toString();
    var pos = item.lastIndexOf(":");
    // 56557657
    String getItemId = (pos != -1) ? item.substring(0, pos) : item;
    

    print("\nThis is itemID now = $getItemId");
    separeteItemIdsList.add(getItemId);
  }

  print("\nThis is items List now = ");
  print(separeteItemIdsList);

  return separeteItemIdsList;
}

seperateOrderItemQuantities(orderIDs) {
  List<String> separeteItemQuantityList = [];
  List<String> defaultItemList = [];
  int i = 1;
  defaultItemList = List<String>.from(orderIDs);

  for (i; i < defaultItemList.length; i++) {
    // id:count
    String item = defaultItemList[i].toString();
    // count
    List<String> listItemCharacters = item.split(":").toList();
    var quanNumber = int.parse(listItemCharacters[1].toString());
    print("\n This is quantity Number : ${quanNumber.toString()}");

    separeteItemQuantityList.add(quanNumber.toString());
  }

  print("\nThis is items List now = ");
  print(separeteItemQuantityList);

  return separeteItemQuantityList;
}


seperateItemIDs() {
  List<String> separeteItemIdsList = [], defaultItemList = [];
  int i = 0;
  defaultItemList = sharedPreferences!.getStringList("userCart")!;

  for (i; i < defaultItemList.length; i++) {
     // 56557657:7
    String item = defaultItemList[i].toString();
    var pos = item.lastIndexOf(":");
    // 56557657
    String getItemId = (pos != -1) ? item.substring(0, pos) : item;

    print("\nThis is itemID now = $getItemId");
    separeteItemIdsList.add(getItemId);
  }

  print("\nThis is items List now = ");
  print(separeteItemIdsList);

  return separeteItemIdsList;
}

addItemToCart(String? foodItemId, BuildContext context, int itemCounter) {
  List<String>? tempList = sharedPreferences!.getStringList("userCart");
  tempList!.add(foodItemId! + ":$itemCounter");
  // 56557657:7

  FirebaseFirestore.instance
      .collection("users")
      .doc(firebaseAuth.currentUser!.uid)
      .update({"userCart": tempList}).then((value) {
    Fluttertoast.showToast(msg: "Item Added Successfully");
    sharedPreferences!.setStringList("userCart", tempList);

    // update the badge
    Provider.of<CartItemCounter>(context, listen: false)
        .displayCartListItemsNumber();
  });
}

seperateItemQuantities() {
  List<int> separeteItemQuantityList = [];
  List<String> defaultItemList = [];
  int i = 1;
  defaultItemList = sharedPreferences!.getStringList("userCart")!;

  for (i; i < defaultItemList.length; i++) {
    // id:count
    String item = defaultItemList[i].toString();
    // count
    List<String> listItemCharacters = item.split(":").toList();
    var quanNumber = int.parse(listItemCharacters[1].toString());
    print("\n This is quantity Number : ${quanNumber.toString()}");

    separeteItemQuantityList.add(quanNumber);
  }

  print("\nThis is items List now = ");
  print(separeteItemQuantityList);

  return separeteItemQuantityList;
}

clearCartNow(context){
  sharedPreferences!.setStringList("userCart", ['garbageValue']);
  List<String>? emptyList = sharedPreferences!.getStringList("userCart");

  FirebaseFirestore.instance
  .collection("users")
  .doc(firebaseAuth.currentUser!.uid)
  .update({"userCart": emptyList}).then((value) {
    sharedPreferences!.setStringList("userCart", emptyList!);
    Provider.of<CartItemCounter>(context, listen: false).displayCartListItemsNumber();

   
  });
}