import 'package:flutter/material.dart';
import 'package:foodii_users_app/assistantMethods/address_changer.dart';
import 'package:foodii_users_app/assistantMethods/total_amount.dart';
import 'package:foodii_users_app/mainScreens/placed_order_screen.dart';
import 'package:foodii_users_app/maps/maps.dart';
import 'package:foodii_users_app/models/address.dart';
import 'package:provider/provider.dart';

class AddressDesign extends StatefulWidget {
  final Address? model;
  final int? currentIndex;
  final int? value;
  final String? addressID;
  final double? totalAmount;
  final String? sellerUID;

  const AddressDesign({
    this.model,
    this.currentIndex,
    this.value,
    this.addressID,
    this.totalAmount,
    this.sellerUID,
  });

  @override
  State<AddressDesign> createState() => _AddressDesignState();
}

class _AddressDesignState extends State<AddressDesign> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // select this address

        Provider.of<AddressChanger>(context, listen: false)
            .displayResult(widget.value);
      },
      child: Card(
        color: Colors.cyan.withOpacity(0.4),
        child: Column(
          children: [
            // address info
            Row(
              children: [
                Radio(
                    value: widget.value!,
                    groupValue: widget.currentIndex!,
                    onChanged: (val) {
                      // provider

                      Provider.of<AddressChanger>(context, listen: false)
                          .displayResult(val);
                      print(val);
                    }),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Table(
                        children: [
                          TableRow(
                            children: [
                              const Text(
                                "Name: ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(widget.model!.name.toString())
                            ],
                          ),
                          TableRow(
                            children: [
                              Text(
                                "Phone Number: ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(widget.model!.phoneNumber.toString())
                            ],
                          ),
                          TableRow(
                            children: [
                              Text(
                                "Flat Number: ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(widget.model!.flatNmuber.toString())
                            ],
                          ),
                          TableRow(
                            children: [
                              Text(
                                "City: ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(widget.model!.city.toString())
                            ],
                          ),
                          TableRow(
                            children: [
                              Text(
                                "State: ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(widget.model!.state.toString())
                            ],
                          ),
                          TableRow(
                            children: [
                              Text(
                                "Full Address: ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(widget.model!.fullAddress.toString())
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
            //  button
            ElevatedButton(
              onPressed: () {

                MapsUtils.openMapWithPosition(widget.model!.lat!, widget.model!.lng!);

                // MapsUtils.openMapWithAddress(widget.model!.fullAddress!);

              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black54),
              child:const Text("Check on Maps"),
            ),

            //  button

            widget.value == Provider.of<AddressChanger>(context).count
                ? ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, 
                      MaterialPageRoute(builder: (c) => PlacedOrderScreen(
                        addressID: widget.addressID,
                        totalAmount: widget.totalAmount,
                        sellerUID: widget.sellerUID
                      )));
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: const Text("Proceed"),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
