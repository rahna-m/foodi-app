import 'package:flutter/material.dart';
import 'package:foodii_users_app/authentication/auth_screen.dart';
import 'package:foodii_users_app/global/global.dart';
import 'package:foodii_users_app/mainScreens/address_screen.dart';
import 'package:foodii_users_app/mainScreens/history_screen.dart';
import 'package:foodii_users_app/mainScreens/home_screen.dart';
import 'package:foodii_users_app/mainScreens/my_orders_screen.dart';
import 'package:foodii_users_app/mainScreens/search_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          // header Drawer 
          Container(
            padding: const EdgeInsets.only(top: 25, bottom: 10),
            child: Column(
              children: [
                Material(
                  borderRadius: const BorderRadius.all(Radius.circular(80)),
                  elevation: 10,
                  child: Padding(padding: 
                 const EdgeInsets.all(1.0),
                  child: Container(height: 160,
                  width: 160,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(sharedPreferences!.getString("photoUrl")!),
                  ),),),
                ), const SizedBox(height: 10,),
                Text(sharedPreferences!.getString("name")!, 
                style: const TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TrainOne'),),

              ],
            ),
          ),
        
        const SizedBox(height: 12,),
         // header Drawer 

       Container(
        padding: const EdgeInsets.only(top: 1.0),
        child:  Column(
          children: [
           const Divider(height: 10, color: Colors.grey, thickness: 2,),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.black,),
              title: const Text("Home",
              style: TextStyle(color: Colors.black),),
              onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (c) => const HomeScreen()));
              },
            ),
             const Divider(height: 10, color: Colors.grey, thickness: 2,),

             ListTile(
              leading: const Icon(Icons.reorder, color: Colors.black,),
              title: const Text("My Orders",
              style: TextStyle(color: Colors.black),),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (c) =>  MyOrdersScreen()));
              },
            ),
             const Divider(height: 10, color: Colors.grey, thickness: 2,),

             ListTile(
              leading: const Icon(Icons.access_time, color: Colors.black,),
              title: const Text("History",
              style: TextStyle(color: Colors.black),),
              onTap: () {

                  Navigator.push(context, MaterialPageRoute(builder: (c) =>  HistoryScreen()));
            
                
              },
            ),
             const Divider(height: 10, color: Colors.grey, thickness: 2,),

             ListTile(
              leading: const Icon(Icons.search, color: Colors.black,),
              title: const Text("Search",
              style: TextStyle(color: Colors.black),),
              onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (c) => const SearchScreen()));
              
              },
            ),
             const Divider(height: 10, color: Colors.grey, thickness: 2,),

             ListTile(
              leading: const Icon(Icons.add_location, color: Colors.black,),
              title: const Text("Add New Address",
              style: TextStyle(color: Colors.black),),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (c) => const AddressScreen()));
              
              },
            ),
             const Divider(height: 10, color: Colors.grey, thickness: 2,),

             ListTile(
              leading: const Icon(Icons.exit_to_app, color: Colors.black,),
              title: const Text("Sign Out",
              style: TextStyle(color: Colors.black),),
              onTap: () {
                firebaseAuth.signOut().then((value) {
           Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (c) => const AuthScreen()), (route) => false);
        }); 
              },
            ),
             const Divider(height: 10, color: Colors.grey, thickness: 2,),
            
          ],
        ),
       )
       
       
        ],
      ),
    );
  }
}