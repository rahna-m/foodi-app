import 'package:flutter/material.dart';
import 'package:foodii_users_app/mainScreens/items_screen.dart';
import 'package:foodii_users_app/models/menus.dart';

import 'package:foodii_users_app/models/sellers.dart';

class MenusDesignWidget extends StatefulWidget {

  Menus? model;
  BuildContext? context;
   MenusDesignWidget({
    Key? key,
    this.model,
    this.context,
  }) : super(key: key);

  @override
  State<MenusDesignWidget> createState() => _MenusDesignWidgetState();
}

class _MenusDesignWidgetState extends State<MenusDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (c) => ItemsScreen(model: widget.model)));
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
            Image.network(widget.model!.thumbnailUrl!, 
            height: 210, fit: BoxFit.cover,),
           const SizedBox(height: 1.0,),
            Text(widget.model!.menuTitle!,
            style: const TextStyle(color: Colors.cyan, 
            fontSize: 20, fontFamily: "TrainOne"),
            
            ),

            Text(widget.model!.menuInfo!,
            style: const TextStyle(color: Colors.grey, 
            fontSize: 12, fontFamily: "TrainOne"),
            
            ),
             Divider(height: 4,
            thickness: 3,
            color: Colors.grey[300],),
          ],
        ),
      ),),
    );
  }
}