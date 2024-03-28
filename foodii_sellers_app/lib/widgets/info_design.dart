import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodii_sellers_app/global/global.dart';
import 'package:foodii_sellers_app/mainScreens/items_screen.dart';
import 'package:foodii_sellers_app/model/menus.dart';


class IndoDesignWidget extends StatefulWidget {

  Menus? model;
  BuildContext? context;
   IndoDesignWidget({
    Key? key,
    this.model,
    this.context,
  }) : super(key: key);

  @override
  State<IndoDesignWidget> createState() => _IndoDesignWidgetState();
}

class _IndoDesignWidgetState extends State<IndoDesignWidget> {

  deleteMenu(String menuID){
    FirebaseFirestore.instance
    .collection("sellers")
    .doc(sharedPreferences!.getString("uid"))
    .collection("menus")
    .doc(menuID)
    .delete();

    Fluttertoast.showToast(msg: "Menu Deleted");
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemsScreen(model: widget.model!,)));
      },
      splashColor: Colors.amber,
      child: Padding(padding: const EdgeInsets.all(5), 
      child: Container(
        height: 285,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Divider(height: 4,
            thickness: 3,
            color: Colors.grey[300],),

            // CircleAvatar(backgroundImage: NetworkImage(widget.model!.thumbnailUrl!,), radius: 35 ,),
            Image.network(widget.model!.thumbnailUrl!, 
            height: 210, fit: BoxFit.cover,),
           const SizedBox(height: 1.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.model!.menuTitle!,
                style: const TextStyle(color: Colors.cyan, 
                fontSize: 20, fontFamily: "TrainOne"),
                
                ),

                IconButton(onPressed: (){
                  // Delete menu

                  deleteMenu(widget.model!.menuID!);
                },
                 icon: const Icon(Icons.delete_sweep,
                 color: Colors.pinkAccent))
              ],
            ),

            // Text(widget.model!.menuInfo!,
            // style: const TextStyle(color: Colors.grey, 
            // fontSize: 12, fontFamily: "TrainOne"),
            
            // ),
             Divider(height: 4,
            thickness: 3,
            color: Colors.grey[300],),
          ],
        ),
      ),),
    );
  }
}