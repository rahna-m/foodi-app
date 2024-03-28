import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodii_riders_app/assistant_methods/get_current_location.dart';
import 'package:foodii_riders_app/global/global.dart';
import 'package:foodii_riders_app/mainScreens/parcel_delivering_screen.dart';
import 'package:foodii_riders_app/maps/map_utils.dart';

class ParcelPickingScreen extends StatefulWidget {
  String? purchaserId;
  String? purchaserAddress;
  String? purchaserLat;
  String? purchaserLng;
  String? sellerId;
  String? getOrderID;

  ParcelPickingScreen({
    Key? key,
    this.purchaserId,
    this.purchaserAddress,
    this.purchaserLat,
    this.purchaserLng,
    this.sellerId,
    this.getOrderID,
  }) : super(key: key);

  @override
  State<ParcelPickingScreen> createState() => _ParcelPickingScreenState();
}

class _ParcelPickingScreenState extends State<ParcelPickingScreen> {
  double? sellerLat, sellerLng;

  getSellerData() async {
    FirebaseFirestore.instance
        .collection("sellers")
        .doc(widget.sellerId)
        .get()
        .then((DocumentSnapshot) {
      sellerLat = DocumentSnapshot.data()!["Lat"];
      sellerLng = DocumentSnapshot.data()!["lng"];
    });
  }

  @override
  void initState() {
    super.initState();
    getSellerData();
  }

  confirmParcelHasBeenPicked(getOrderId, sellerId, purchaserId,
      purchaserAddress, purchaserLat, purchaserLng) {
    FirebaseFirestore.instance.collection("orders").doc(getOrderId).update({
      "status": "delivering",
      "address": completeAddress,
      "lat": position!.latitude,
      "lng": position!.longitude
    });
    Navigator.push(context,
        MaterialPageRoute(builder: (c) =>  ParcelDeliveringScreen(
          purchaserId: purchaserId,
          purchaserAddress : purchaserAddress,
          purchaserLat : purchaserLat,
          purchaserLng : purchaserLng,
          sellerId : sellerId,
          getOrderId: getOrderId
        )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "images/confirm1.png",
            width: 350,
          ),
          const SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () {
              // show location from rider current location towards seller location
              MapUtils.lauchMapFromSourceToDestination(position!.latitude,
                  position!.longitude, sellerLat, sellerLng);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "images/restaurant.png",
                  width: 50,
                ),
                const SizedBox(
                  width: 7,
                ),
                const Column(
                  children: [
                    SizedBox(
                      height: 13,
                    ),
                    Text(
                      "Show Cafe/Restaurant Location",
                      style: TextStyle(
                          fontFamily: "Signatra",
                          fontSize: 18,
                          letterSpacing: 2),
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 35,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: InkWell(
                onTap: () {
                  UserLocation uLocation = UserLocation();
                  uLocation.getCurrentLocation();
                  //   confirmed - that rider has picked parcel from seller
                  confirmParcelHasBeenPicked(
                    widget.getOrderID, 
                    widget.sellerId,
                    widget.purchaserId, 
                    widget.purchaserAddress, 
                    widget.purchaserLat, 
                    widget.purchaserLng);
                },
                child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Colors.cyan,
                            Colors.amber,
                          ],
                          begin: FractionalOffset(0.0, 0.0),
                          end: FractionalOffset(1.0, 0.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp)),
                  width: MediaQuery.of(context).size.width - 90,
                  height: 50,
                  child: const Center(
                    child: Text(
                      "Order has been Picked - Confirmed",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
