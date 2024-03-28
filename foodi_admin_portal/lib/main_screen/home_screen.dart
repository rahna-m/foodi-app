import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodi_admin_portal/authentication/login_screen.dart';
import 'package:foodi_admin_portal/riders/all_blocked_riders_screen.dart';
import 'package:foodi_admin_portal/riders/all_verified_riders_screen.dart';
import 'package:foodi_admin_portal/sellers/all_blocked_sellers_screen.dart';
import 'package:foodi_admin_portal/sellers/all_verified_sellers_screen.dart';
import 'package:foodi_admin_portal/users/all_blocked_users_screen.dart';
import 'package:foodi_admin_portal/users/all_verified_users_screen.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String timeText = "";
  String dateText = "";
 

  String formatCurrentLiveTime(DateTime time){
    return DateFormat("hh:mm:ss a").format(time);
  }

  String formatCurrentDate(DateTime date){
    return DateFormat("dd MMMM, yyyy").format(date);
  }

  getCurrentLiveTime(){
    final DateTime timeNow = DateTime.now();
    final String liveTime = formatCurrentLiveTime(timeNow);
    final String liveDate = formatCurrentDate(timeNow);

    if(this.mounted){
      setState(() {
        timeText = liveTime;
        dateText = liveDate;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    // time
   timeText = formatCurrentLiveTime(DateTime.now());

    // date
   dateText = formatCurrentDate(DateTime.now());

   Timer.periodic( const Duration(seconds: 1), (timer) { 
    getCurrentLiveTime();
   });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.amber,
              Colors.cyan
            ],
            begin: FractionalOffset(0, 0),
            end: FractionalOffset(1, 0),
            stops: [0,1],
            tileMode: TileMode.clamp
            )
          ),
        ),
        title: const Text("Admin Portal",
        style: TextStyle(fontSize: 20, letterSpacing: 1, color: Colors.white),),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("$timeText\n$dateText",
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                letterSpacing: 3,
                fontWeight: FontWeight.bold
              ),
              ),
            ),

            // user activate and black accounts button ui

            Row(
               mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // active

                ElevatedButton.icon(onPressed: (){

                   Navigator.push(context, MaterialPageRoute(builder: (c) => const AllVerifiedUsersScreen()));

                }, 
                icon: const Icon(Icons.person_add, color: Colors.white,),
                 label: Text("All Verified\nUsers Accounts".toUpperCase(),
                 style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  letterSpacing: 1

                 ),),
                 style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  backgroundColor: Colors.amber
                 ),),

                const SizedBox(width: 10,),

                 ElevatedButton.icon(onPressed: (){

                    Navigator.push(context, MaterialPageRoute(builder: (c) => const AllBlockedUsersScreen()));

                }, 
                icon: const Icon(Icons.block_flipped, color: Colors.white,),
                 label: Text("All Blocked\nUsers Accounts".toUpperCase(),
                 style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  letterSpacing: 1

                 ),),
                 style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  backgroundColor: Colors.cyan
                 ),)
              ],
            ),
          

           // sellers activate and black accounts button ui

             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // active

                ElevatedButton.icon(onPressed: (){

                   Navigator.push(context, MaterialPageRoute(builder: (c) => const AllVerifiedSellersScreen()));

                }, 
                icon: const Icon(Icons.person_add, color: Colors.white,),
                 label: Text("All Verified\nSellers Accounts".toUpperCase(),
                 style: const TextStyle(
                  fontSize: 11,
                  color: Colors.white,
                  letterSpacing: 1

                 ),),
                 style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  backgroundColor: Colors.cyan
                 ),),

                const SizedBox(width: 10,),

                 ElevatedButton.icon(onPressed: (){

                   Navigator.push(context, MaterialPageRoute(builder: (c) => const AllBlockedSellersScreen()));

                }, 
                icon: const Icon(Icons.block_flipped, color: Colors.white,),
                 label: Text("All Blocked\nSellers Accounts".toUpperCase(),
                 style: const TextStyle(
                  fontSize: 11,
                  color: Colors.white,
                  letterSpacing: 1

                 ),),
                 style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  backgroundColor: Colors.amber
                 ),)
              ],
            ),
          
            // riders activate and black accounts button ui

              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // active

                ElevatedButton.icon(onPressed: (){

                   Navigator.push(context, MaterialPageRoute(builder: (c) => const AllVerifiedRidersScreen()));

                }, 
                icon: const Icon(Icons.person_add, color: Colors.white,),
                 label: Text("All Verified\nRiders Accounts".toUpperCase(),
                 style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  letterSpacing: 1

                 ),),
                 style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  backgroundColor: Colors.amber
                 ),),

                const SizedBox(width: 10,),

                 ElevatedButton.icon(onPressed: (){

                   Navigator.push(context, MaterialPageRoute(builder: (c) => const AllBlockedRidersScreen()));

                }, 
                icon: const Icon(Icons.block_flipped, color: Colors.white,),
                 label: Text("All Blocked\nRiders Accounts".toUpperCase(),
                 style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  letterSpacing: 1

                 ),),
                 style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  backgroundColor: Colors.cyan
                 ),)
              ],
            ),

            // logout

             ElevatedButton.icon(onPressed: (){

              FirebaseAuth.instance.signOut();
              Navigator.push(context, MaterialPageRoute(builder: (c) => const LoginScreen()));

                }, 
                icon: const Icon(Icons.logout, color: Colors.white,),
                 label: Text("Logout".toUpperCase(),
                 style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  letterSpacing: 3

                 ),),
                 style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  backgroundColor: Colors.cyan
                 ),)
          


          ],
        ),
      ),
    );
  }
}