import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodii_riders_app/assistant_methods/get_current_location.dart';
import 'package:foodii_riders_app/authentication/auth_screen.dart';
import 'package:foodii_riders_app/global/global.dart';
import 'package:foodii_riders_app/mainScreens/earnings_screen.dart';
import 'package:foodii_riders_app/mainScreens/histrory_screen.dart';
import 'package:foodii_riders_app/mainScreens/new_orders_screen.dart';
import 'package:foodii_riders_app/mainScreens/not_yet_delivered_screen.dart';
import 'package:foodii_riders_app/mainScreens/parcel_in_progress_screen.dart';
import 'package:foodii_riders_app/splashScreen/splash_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Card makeDashboardItem(String title, IconData iconData, int index) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: Container(
        decoration: index == 0 || index == 3 || index == 4
            ? const BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Colors.amber,
                      Colors.cyan,
                    ],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp))
            : const BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Colors.redAccent,
                      Colors.amber,
                    ],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp)),
        child: InkWell(
          onTap: () {
            if (index == 0) {
              // New Available Orders

              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => NewOrdersScreen()));
            }
            if (index == 1) {
              // Parcels in Progress

              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => ParcelInProgressScreen()));
            }
            if (index == 2) {
              // Not Yet Delivered

              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => NotYetDeliveredScreen()));
            }
            if (index == 3) {
              // History

              Navigator.push(
                  context, MaterialPageRoute(builder: (c) => HistoryScreen()));
            }
            if (index == 4) {
              // total Earnings

              Navigator.push(
                  context, MaterialPageRoute(builder: (c) => EarningsScreen()));
            }
            if (index == 5) {
              // Logout

              firebaseAuth.signOut().then((value) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (c) => const AuthScreen()));
              });
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: [
              const SizedBox(
                height: 40,
              ),
              Center(
                child: Icon(
                  iconData,
                  size: 40,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 15, color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  RestrictBlockedRidersFromUsingApp() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .get()
        .then((snapshot) {
      if (snapshot.data()!["status"] == "approved") {
        Fluttertoast.showToast(msg: "you have been Blocked");

        firebaseAuth.signOut();
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => const MySplashScreen()));
      } else {
        UserLocation? uLocation = UserLocation();
        uLocation.getCurrentLocation();
        getPerParcelDeliveryAmount();
        getRiderPreviousEarnings();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    RestrictBlockedRidersFromUsingApp();
  }

  getRiderPreviousEarnings() {
    FirebaseFirestore.instance
        .collection("riders")
        .doc(sharedPreferences!.getString("uid"))
        .get()
        .then((snap) {
      previousRiderEarnings = snap.data()!["earnings"].toString();
    });
  }

  getPerParcelDeliveryAmount() {
    FirebaseFirestore.instance
        .collection("perDelivery")
        .doc("PiBEaNBvEwYjtFibzcdm")
        .get()
        .then((snap) {
      perParcelDeliveryAmount = snap.data()!['amount'].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
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
          ),
          title: Center(
            child: Text(
              "Welcome ${sharedPreferences!.getString("name")!}",
              style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.black,
                  fontFamily: "Signatra",
                  letterSpacing: 2),
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 1),
          child: GridView.count(
            crossAxisCount: 2,
            padding: const EdgeInsets.all(2),
            children: [
              makeDashboardItem("New Available Orders", Icons.assignment, 0),
              makeDashboardItem(
                  "Parcels in Progress", Icons.airport_shuttle, 1),
              makeDashboardItem("Not Yet Delivered", Icons.location_history, 2),
              makeDashboardItem("History", Icons.done_all, 3),
              makeDashboardItem("Total Earnings", Icons.monetization_on, 4),
              makeDashboardItem("Logout", Icons.logout, 5),
            ],
          ),
        ));
  }
}
