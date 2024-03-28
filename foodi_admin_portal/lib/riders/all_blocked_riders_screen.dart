import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodi_admin_portal/main_screen/home_screen.dart';
import 'package:foodi_admin_portal/widgets/simple_app_bar.dart';

class AllBlockedRidersScreen extends StatefulWidget {
  const AllBlockedRidersScreen({super.key});

  @override
  State<AllBlockedRidersScreen> createState() =>
      _AllBlockedRidersScreenState();
}

class _AllBlockedRidersScreenState extends State<AllBlockedRidersScreen> {
  displayDialogBoxForActivatingAccount(riderDocumentID) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Activate Account",
              style: TextStyle(
                  fontSize: 15, letterSpacing: 1, fontWeight: FontWeight.bold),
            ),
            content: const Text(
              "Do you want to Activate this Account?",
              style: TextStyle(
                fontSize: 15,
                letterSpacing: 1,
              ),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("No")),
              ElevatedButton(
                  onPressed: () {
                    Map<String, dynamic> riderDataMap = {
                      // blocked

                      "status": "approved",
                    };

                    FirebaseFirestore.instance
                        .collection("riders")
                        .doc(riderDocumentID)
                        .update(riderDataMap)
                        .then((value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => const HomeScreen()));
                      SnackBar snackBar = const SnackBar(
                        content: Text(
                          "Activated Successfully.",
                          style: TextStyle(fontSize: 16),
                        ),
                        backgroundColor: Colors.pinkAccent,
                        duration: Duration(seconds: 2),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    });
                  },
                  child: const Text("Yes"))
            ],
          );
        });
  }

  QuerySnapshot? allRiders;
  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection("riders")
        .where("status", isEqualTo: "not approved")
        .get()
        .then((allVerifiedRiders) {
      setState(() {
        allRiders = allVerifiedRiders;
      });
    });
  }

  Widget displayNonVerifiedRiderDesign() {
    if (allRiders != null) {
      return ListView.builder(
          itemCount: allRiders!.docs.length,
          itemBuilder: (context, i) {
            return Card(
              margin: const EdgeInsets.only(top: 10, left: 15, right: 15),
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Column(
                  children: [
                    ListTile(
                      leading: Container(
                        width: 65,
                        height: 65,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(
                                  allRiders!.docs[i].get("riderAvatarUrl"),
                                ),
                                fit: BoxFit.fill)),
                      ),
                      title: Text(
                        allRiders!.docs[i].get("riderName"),
                        style: const TextStyle(fontSize: 18),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                          Text(
                            allRiders!.docs[i].get("riderEmail"),
                            style: const TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber),
                        onPressed: () {
                          SnackBar snackBar = SnackBar(
                            content: Text(
                              "${"Total Earnings".toUpperCase()} € ${allRiders!.docs[i].get("earnings").toString()}",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                            backgroundColor: Colors.amber,
                            duration: Duration(seconds: 2),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        icon: const Icon(
                          Icons.person_pin_sharp,
                          color: Colors.white,
                        ),
                        label: Text(
                          "${"Total Earnings".toUpperCase()} € ${allRiders!.docs[i].get("earnings").toString()}",
                          style: const TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              letterSpacing: 1),
                        )),
                    ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        onPressed: () {
                          displayDialogBoxForActivatingAccount(
                              allRiders!.docs[i].id);
                        },
                        icon: const Icon(
                          Icons.person_pin_sharp,
                          color: Colors.white,
                        ),
                        label: Text(
                          "Activate this Account".toUpperCase(),
                          style: const TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              letterSpacing: 1),
                        )),
                  ],
                ),
              ),
            );
          });
    } else {
      return const Center(
        child: Text(
          "No Record Found",
          style: TextStyle(fontSize: 16),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: "All Blocked Riders Accounts",
      ),
      body: Container(
        width: MediaQuery.of(context).size.width * 1,
        child: displayNonVerifiedRiderDesign(),
      ),
    );
  }
}
