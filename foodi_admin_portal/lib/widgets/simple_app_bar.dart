import 'package:flutter/material.dart';
import 'package:foodi_admin_portal/main_screen/home_screen.dart';

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
        leading: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (c) => const HomeScreen()));
        }, 
        icon: const Icon(Icons.arrow_back, color: Colors.white,)),
        centerTitle: true,
        title:  Text(
          title!,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
       );
  }
  
}