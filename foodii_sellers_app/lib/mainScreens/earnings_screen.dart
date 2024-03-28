import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodii_sellers_app/global/global.dart';
import 'package:foodii_sellers_app/splashScreen/splash_screen.dart';


class EarningsScreen extends StatefulWidget {
  const EarningsScreen({super.key});

  @override
  State<EarningsScreen> createState() => _EarningsScreenState();
}

class _EarningsScreenState extends State<EarningsScreen> {

  double sellerTotalEarnings = 0;

  retrieveSellerEarnings() async{

    await FirebaseFirestore.instance
    .collection("sellers")
    .doc(sharedPreferences!.getString("uid"))
    .get()
    .then((snap) {
      setState(() {
        sellerTotalEarnings = double.parse(snap.data()!['earnings'].toString());
      });
    });

  }

  @override
  void initState() {
    super.initState();
    retrieveSellerEarnings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('€ ${sellerTotalEarnings.toString()}', 
            style: const TextStyle(fontSize: 60,
            color: Colors.white,
            fontFamily: 'Signatra'),),
           const Text('Total Earnings', 
            style:  TextStyle(fontSize: 20,
            color: Colors.green,
            letterSpacing: 3,
            fontWeight: FontWeight.bold),),
           const SizedBox(
              height: 20,
              width: 200,
              child: Divider(
                color: Colors.white,
                thickness: 1.5,
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (c) => const MySplashScreen()));
              },
              child: const Card(
                color: Colors.white54,
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 100),
                child: ListTile(
                  contentPadding: EdgeInsets.only(left: 20, right: 20),
                  leading: Icon(
                    Icons.arrow_back,
                    color: Colors.white,

                  ),
                  title: Text(
                    "back",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}