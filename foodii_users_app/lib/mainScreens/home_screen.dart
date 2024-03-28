import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodii_users_app/assistantMethods/assistant_methods.dart';
import 'package:foodii_users_app/authentication/auth_screen.dart';
import 'package:foodii_users_app/authentication/login.dart';
import 'package:foodii_users_app/global/global.dart';
import 'package:foodii_users_app/main.dart';
import 'package:foodii_users_app/models/sellers.dart';
import 'package:foodii_users_app/splashScreen/splash_screen.dart';
import 'package:foodii_users_app/widgets/sellers_design.dart';
import 'package:foodii_users_app/widgets/my_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final items = [
    "slider/0.jpg",
    "slider/1.jpg",
    "slider/2.jpg",
    "slider/3.jpg",
    "slider/4.jpg",
    "slider/5.jpg",
    "slider/6.jpg",
    "slider/7.jpg",
    "slider/8.jpg",
    "slider/9.jpg",
    "slider/10.jpg",
    "slider/11.jpg",
    "slider/12.jpg",
    "slider/13.jpg",
    "slider/14.jpg",
    "slider/15.jpg",
    "slider/16.jpg",
    "slider/17.jpg",
    "slider/18.jpg",
    "slider/19.jpg",
    "slider/20.jpg",
    "slider/21.jpg",
    "slider/22.jpg",
    "slider/23.jpg",
    "slider/24.jpg",
    "slider/25.jpg",
    "slider/26.jpg",
    "slider/27.jpg",
  ];

  RestrictBlockedUsersFromUsingApp() async {
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
        clearCartNow(context);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    RestrictBlockedUsersFromUsingApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
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
          child: Text(sharedPreferences!.getString("name")!),
        ),
      ),
      drawer: const MyDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: MediaQuery.of(context).size.height * .3,
                width: MediaQuery.of(context).size.width,
                child: CarouselSlider(
                    items: items.map((index) {
                      return Builder(builder: ((context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 1.0),
                          decoration: const BoxDecoration(color: Colors.black),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.asset(
                              index,
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                      }));
                    }).toList(),
                    options: CarouselOptions(
                      height: 400,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.8,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 2),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 500),
                      autoPlayCurve: Curves.decelerate,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                      scrollDirection: Axis.horizontal,
                    )),
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("sellers").snapshots(),
              builder: (context, snapshot) {
                return !snapshot.hasData
                    ? const SliverToBoxAdapter(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : SliverStaggeredGrid.countBuilder(
                        crossAxisCount: 1,
                        staggeredTileBuilder: (c) => const StaggeredTile.fit(1),
                        itemBuilder: (context, index) {
                          Sellers sModel = Sellers.fromJson(
                              snapshot.data!.docs[index].data()!
                                  as Map<String, dynamic>);

                          //  design fro display sellers- cafes- restuarents
                          return SellersDesignWidget(
                            model: sModel,
                            context: context,
                          );
                        },
                        itemCount: snapshot.data!.docs.length);
              })
        ],
      ),
    );
  }
}
