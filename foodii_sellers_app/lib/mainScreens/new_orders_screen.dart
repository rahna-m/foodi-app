import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodii_sellers_app/assistant_methods/assistant_methods.dart';
import 'package:foodii_sellers_app/global/global.dart';
import 'package:foodii_sellers_app/widgets/order_card.dart';
import 'package:foodii_sellers_app/widgets/progress_bar.dart';
import 'package:foodii_sellers_app/widgets/simple_app_bar.dart';




class NewOrdersScreen extends StatefulWidget
{
  @override
  _NewOrdersScreenState createState() => _NewOrdersScreenState();
}



class _NewOrdersScreenState extends State<NewOrdersScreen>
{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SimpleAppBar(title: "My Orders",),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("orders")
              .where("status", isEqualTo: "normal")
             .where("sellerUID", isEqualTo: sharedPreferences!.getString('uid'))
              .snapshots(),
          builder: (c, snapshot)
          {
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (c, index)
                    {
                      return FutureBuilder<QuerySnapshot>(
                        future: FirebaseFirestore.instance
                            .collection("items")
                            .where("itemID", whereIn: seperateOrderItemIDs((snapshot.data!.docs[index].data()! as Map<String, dynamic>) ["productIDs"]))
                            .where("sellerUID", whereIn: (snapshot.data!.docs[index].data()! as Map<String, dynamic>)["uid"])
                            .orderBy("publishedDate", descending: true)
                            .get(),
                        builder: (c, snap)
                        {
                          return snap.hasData
                              ? OrderCard(
                            itemCount: snap.data!.docs.length,
                            data: snap.data!.docs,
                            orderID: snapshot.data!.docs[index].id,
                            seperateQuantitiesList: seperateOrderItemQuantities((snapshot.data!.docs[index].data()! as Map<String, dynamic>)["productIDs"]),
                          )
                              : Center(child: circularProgress());
                        },
                      );
                    },
                  )
                : Center(child: circularProgress(),);
          },
        ),
      ),
    );
  }
}
