import 'package:flutter/material.dart';
import 'package:foodii_users_app/assistantMethods/cart_item_counter.dart';
import 'package:foodii_users_app/mainScreens/cart_screen.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  
  final PreferredSizeWidget? bottom;  
  final String? sellerUID;
   MyAppBar({this.bottom, this.sellerUID});

  @override
  State<MyAppBar> createState() => _MyAppBarState();
  
  @override
  Size get preferredSize => bottom == null 
  ? Size(56, AppBar().preferredSize.height)
  : Size(56, 80+AppBar().preferredSize.height);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
         automaticallyImplyLeading: true,
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
        title: const Center(
          child: Text(
            "iFood",
            style:  TextStyle(fontSize: 30, fontFamily: "Signatra"),
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                  onPressed: () {
                    // send user to cart screen

                    Navigator.push(context, MaterialPageRoute(builder: (c) => 
                     CartScreen(sellerUID: widget.sellerUID)));
                  },
                  icon: const Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  )),
             Positioned(
                  child: Stack(
                children: [
                const  Icon(
                    Icons.brightness_1,
                    size: 20.0,
                    color: Colors.green,
                  ),
                  Positioned(
                      top: 3,
                      right: 5,
                      child: Center(
                        child: Consumer<CartItemCounter>(builder: (context, counter, c){
                          return Text(counter.count.toString(),
                           style: const TextStyle(color: Colors.white, fontSize: 12),);
                        },)
                      ))
                ],
              ))
            ],
          )
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      );
  
  
  }
}