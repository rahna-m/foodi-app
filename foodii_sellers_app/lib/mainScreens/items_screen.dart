import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:foodii_sellers_app/global/global.dart';
import 'package:foodii_sellers_app/model/items.dart';
import 'package:foodii_sellers_app/model/menus.dart';
import 'package:foodii_sellers_app/uploadScreens/items_upload_screen.dart';
import 'package:foodii_sellers_app/widgets/info_design.dart';
import 'package:foodii_sellers_app/widgets/items_design.dart';
import 'package:foodii_sellers_app/widgets/my_drawer.dart';
import 'package:foodii_sellers_app/widgets/progress_bar.dart';
import 'package:foodii_sellers_app/widgets/text_widget_header.dart';


class ItemsScreen extends StatefulWidget {

  final Menus? model;
  const ItemsScreen({super.key,this.model});

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Navigator.push(context, MaterialPageRoute(builder: (c) =>  ItemsUploadScreen(model: widget.model)));
          }, icon: const Icon(Icons.library_add, color: Colors.white,))
        ],
        ),
        drawer: MyDrawer(),
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(delegate: TextWidgetHeader(title: "My "+ widget.model!.menuTitle.toString() + "'s Items")),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
            .collection("sellers")
            .doc(sharedPreferences!.getString("uid"))
            .collection("menus")
            .doc(widget.model!.menuID)
            .collection("items")
            .orderBy("publishedDate", descending: true)
            .snapshots(), 
            builder: (context, snapshot){
            return !snapshot.hasData ? 
            SliverToBoxAdapter(child: 
            Center(child: 
            circularProgress(),),) 
            : SliverStaggeredGrid.
            countBuilder(crossAxisCount: 1, 
            staggeredTileBuilder: (c) => 
            const StaggeredTile.fit(1), 
            itemBuilder: (context, index){
              Items model = Items
              .fromJson(snapshot.data!.docs[index].data()!
               as Map<String, dynamic>);
              return ItemsDesignWidget(
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