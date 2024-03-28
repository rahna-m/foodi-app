import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:foodii_riders_app/assistant_methods/get_current_location.dart';
import 'package:foodii_riders_app/global/global.dart';
import 'package:foodii_riders_app/mainScreens/home_screen.dart';
import 'package:foodii_riders_app/mainScreens/parcel_picking_screen.dart';
import 'package:foodii_riders_app/models/address.dart';

class ShipmentAddressDesign extends StatelessWidget {
  final Address? model;
  final String? orderStatus;
  final String? orderId;
  final String? sellerId;
  final String? orderByUser;

  const ShipmentAddressDesign({
    Key? key,
    this.model,
    this.orderStatus,
    this.orderId,
    this.sellerId,
    this.orderByUser,
  }) : super(key: key);

  confirmedParcelShipment(BuildContext context, String getOrderID, String sellerId, String purchaserId){
    FirebaseFirestore.instance
    .collection("orders")
    .doc(getOrderID)
    .update({
      "riderUID" : sharedPreferences!.getString("uid"),
      "riderName" : sharedPreferences!.getString("name"),
      "status" : "picking",
      "lat" : position!.latitude,
      "lng" : position!.longitude,
      "address" : completeAddress,
    });
    // send rider to shipmentScreen

    Navigator.push(context, MaterialPageRoute(builder: (c) => ParcelPickingScreen(
      purchaserId: purchaserId,
      purchaserAddress: model!.fullAddress,
      purchaserLat: model!.lat.toString(),
      purchaserLng: model!.lng.toString(),
      sellerId: sellerId,
      getOrderID: getOrderID

    )));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Shipping Details:",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
            width: MediaQuery.of(context).size.width,
            child: Table(
              children: [
                TableRow(children: [
                  const Text(
                    "Name",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(model!.name!)
                ]),
                TableRow(children: [
                  const Text(
                    "Phone Number",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(model!.phoneNumber!)
                ])
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              model!.fullAddress!,
              textAlign: TextAlign.justify,
            ),
          ),

           orderStatus == "ended"
              ? Container()
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: InkWell(
                      onTap: () {

                        UserLocation? uLocation = UserLocation();
                        uLocation.getCurrentLocation();

                        confirmedParcelShipment(context, orderId!, sellerId!, orderByUser!);


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
                        width: MediaQuery.of(context).size.width - 40,
                        height: 50,
                        child: const Center(
                          child: Text(
                            "Confirm - To Deliver this Parcel",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
       


          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
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
                  width: MediaQuery.of(context).size.width - 40,
                  height: 50,
                  child: const Center(
                    child: Text(
                      "Go Back",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ),
            ),
          ),
          
         const SizedBox(height: 20,)
          ],
      ),
    );
  }
}
