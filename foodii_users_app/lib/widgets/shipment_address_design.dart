import 'package:flutter/material.dart';
import 'package:foodii_users_app/mainScreens/home_screen.dart';
import 'package:foodii_users_app/models/address.dart';
import 'package:foodii_users_app/splashScreen/splash_screen.dart';

class ShipmentAddressDesign extends StatelessWidget {
  final Address? model;

  const ShipmentAddressDesign({super.key, this.model});

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
      
        const  SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              model!.fullAddress!,
            textAlign: TextAlign.justify,),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const MySplashScreen()));
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
                        child: Text("Go Back",
                        style: TextStyle(
                          color: Colors.white, fontSize: 15
                        ),),
                      ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
