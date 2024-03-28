import 'package:flutter/material.dart';
import 'package:foodii_sellers_app/mainScreens/item_detail_screen.dart';
import 'package:foodii_sellers_app/mainScreens/items_screen.dart';
import 'package:foodii_sellers_app/model/items.dart';
import 'package:foodii_sellers_app/model/menus.dart';


class ItemsDesignWidget extends StatefulWidget {

  Items? model;
  BuildContext? context;
   ItemsDesignWidget({
    Key? key,
    this.model,
    this.context,
  }) : super(key: key);

  @override
  State<ItemsDesignWidget> createState() => _ItemsDesignWidgetState();
}

class _ItemsDesignWidgetState extends State<ItemsDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
         Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemDetailsScreen(model: widget.model!,)));
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

            const SizedBox(height: 1.0,),
            Text(widget.model!.title!,
            style: const TextStyle(color: Colors.cyan, 
            fontSize: 20, fontFamily: "TrainOne"),
            
            ),

            // CircleAvatar(backgroundImage: NetworkImage(widget.model!.thumbnailUrl!,), radius: 35 ,),
            Image.network(widget.model!.thumbnailUrl!, 
            height: 210, fit: BoxFit.cover,),
             const SizedBox(height: 2.0,),

            Text(widget.model!.shortInfo!,
            style: const TextStyle(color: Colors.grey, 
            fontSize: 12, fontFamily: "TrainOne"),
            
            ),
             const SizedBox(height: 1.0,),
             Divider(height: 4,
            thickness: 3,
            color: Colors.grey[300],),
          ],
        ),
      ),),
    );
  }
}