import 'package:flutter/material.dart';

class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget{
  String? title;
  final PreferredSizeWidget? bottom;
   SimpleAppBar({this.title, this.bottom, super.key});

   @override
  Size get preferredSize => bottom == null ? Size(56, AppBar().preferredSize.height): Size(56, 80+AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
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
        centerTitle: true,
        title:  Text(
          title!,
          style: TextStyle(fontSize: 30, fontFamily: "Signatra"),
        ),
       );
  }
  
}