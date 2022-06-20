import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodpanda_users_app/assistantMethods/cart_item_counter.dart';
import 'package:foodpanda_users_app/assistantMethods/total_amount.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'global/global.dart';
import 'splashScreen/splash_screen.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c)=>CartItemCounter()),
        ChangeNotifierProvider(create: (c)=>TotalAmount())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Users App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:const MySplashScreen(),
      ),
    );
  }
}
