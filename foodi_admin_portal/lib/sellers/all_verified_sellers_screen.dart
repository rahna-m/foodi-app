import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodi_admin_portal/main_screen/home_screen.dart';
import 'package:foodi_admin_portal/widgets/simple_app_bar.dart';

class AllVerifiedSellersScreen extends StatefulWidget {
  const AllVerifiedSellersScreen({super.key});

  @override
  State<AllVerifiedSellersScreen> createState() =>
      _AllVerifiedSellersScreenState();
}

class _AllVerifiedSellersScreenState extends State<AllVerifiedSellersScreen> {
  displayDialogBoxForBlockingAccount(sellerDocumentID) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Block Account",
              style: TextStyle(
                  fontSize: 15, letterSpacing: 1, fontWeight: FontWeight.bold),
            ),
            content: const Text(
              "Do you want to block this Account?",
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
                    Map<String, dynamic> sellerDataMap = {
                      // blocked

                      "status": "not approved",
                    };

                    FirebaseFirestore.instance
                        .collection("sellers")
                        .doc(sellerDocumentID)
                        .update(sellerDataMap)
                        .then((value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => const HomeScreen()));
                      SnackBar snackBar = const SnackBar(
                        content: Text(
                          "Blocked Successfully.",
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

  QuerySnapshot? allSellers;
  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection("sellers")
        .where("status", isEqualTo: "approved")
        .get()
        .then((allVerifiedSellers) {
      setState(() {
        allSellers = allVerifiedSellers;
      });
    });
  }

  Widget displayVerifiedSellerDesign() {
    if (allSellers != null) {
      return ListView.builder(
          itemCount: allSellers!.docs.length,
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
                                  allSellers!.docs[i].get("sellerAvatarUrl"),
                                ),
                                fit: BoxFit.fill)),
                      ),
                      title: Text(
                        allSellers!.docs[i].get("sellerName"),
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
                            allSellers!.docs[i].get("sellerEmail"),
                            style: const TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        onPressed: () {
                          SnackBar snackBar = SnackBar(
                            content: Text(
                              "${"Total Earnings".toUpperCase()} € ${allSellers!.docs[i].get("earnings").toString()}",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                            backgroundColor: Colors.green,
                            duration: Duration(seconds: 2),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        icon: const Icon(
                          Icons.person_pin_sharp,
                          color: Colors.white,
                        ),
                        label: Text(
                          "${"Total Earnings".toUpperCase()} € ${allSellers!.docs[i].get("earnings").toString()}",
                          style: const TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              letterSpacing: 1),
                        )),
                    ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        onPressed: () {
                          displayDialogBoxForBlockingAccount(
                              allSellers!.docs[i].id);
                        },
                        icon: const Icon(
                          Icons.person_pin_sharp,
                          color: Colors.white,
                        ),
                        label: Text(
                          "Block this Account".toUpperCase(),
                          style: const TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              letterSpacing: 1),
                        ))
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
        title: "All Verified Sellers Accounts",
      ),
      body: Container(
        width: MediaQuery.of(context).size.width * 1,
        child: displayVerifiedSellerDesign(),
      ),
    );
  }
}
