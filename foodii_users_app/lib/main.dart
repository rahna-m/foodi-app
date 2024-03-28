import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodii_users_app/assistantMethods/address_changer.dart';
import 'package:foodii_users_app/assistantMethods/cart_item_counter.dart';
import 'package:foodii_users_app/assistantMethods/total_amount.dart';
import 'package:foodii_users_app/firebase_options.dart';
import 'package:foodii_users_app/global/global.dart';
import 'package:foodii_users_app/splashScreen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c) => CartItemCounter()),
        ChangeNotifierProvider(create: (c) => TotalAmount()),
        ChangeNotifierProvider(create: (c) => AddressChanger()),
      ],
      child: MaterialApp(
        
        title: 'Users App',
        theme: ThemeData(    
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: false,
        ),
        debugShowCheckedModeBanner: false,
        home: const MySplashScreen(),
      ),
    );
  }

}