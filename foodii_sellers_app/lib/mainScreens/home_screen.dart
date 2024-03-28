import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodii_sellers_app/authentication/auth_screen.dart';
import 'package:foodii_sellers_app/global/global.dart';
import 'package:foodii_sellers_app/model/menus.dart';
import 'package:foodii_sellers_app/splashScreen/splash_screen.dart';
import 'package:foodii_sellers_app/uploadScreens/menus_upload_screen.dart';
import 'package:foodii_sellers_app/widgets/info_design.dart';
import 'package:foodii_sellers_app/widgets/my_drawer.dart';
import 'package:foodii_sellers_app/widgets/progress_bar.dart';
import 'package:foodii_sellers_app/widgets/text_widget_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

   RestrictBlockedSellersFromUsingApp() async {
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
       
      }
    });
  }

  @override
  void initState() {
    super.initState();
     RestrictBlockedSellersFromUsingApp();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
          // automaticallyImplyLeading: false,
         flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.cyan,
              Colors.amber,
            ],
            begin:  FractionalOffset(0.0, 0.0),
            end:  FractionalOffset(1.0, 0.0),
            stops: [0.0,1.0],
            tileMode: TileMode.clamp
            )
          ),
        ),
        title: Center(
          child: Text(
            sharedPreferences!.getString("name")!, 
            style: const TextStyle(fontSize: 30, fontFamily: "Lobster"),
          ),
        ),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (c) => const MenuUploadScreen()));
          }, icon: const Icon(Icons.post_add, color: Colors.white,))
        ],
        ),
       
       
        drawer: const MyDrawer(),
      body: CustomScrollView(
        slivers: [
         SliverPersistentHeader(pinned: true, delegate: TextWidgetHeader(title: "My Menus")),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
            .collection("sellers")
            .doc(sharedPreferences!.getString("uid"))
            .collection("menus")
            .orderBy("publishedDate", descending: true)
            .snapshots(),
             builder: (context, snapshot){
            return !snapshot.hasData ? SliverToBoxAdapter(child: Center(child: circularProgress(),),) : SliverStaggeredGrid.countBuilder(crossAxisCount: 1, 
            staggeredTileBuilder: (c) => const StaggeredTile.fit(1), 
            itemBuilder: (context, index){
              Menus model = Menus.fromJson(snapshot.data!.docs[index].data()! as Map<String, dynamic>);
              return IndoDesignWidget(
                model: model,
                context: context,
              );
            }, itemCount: snapshot.data!.docs.length);
          })
        ],
      ),
    );
  }
}