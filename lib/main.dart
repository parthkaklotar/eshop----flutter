// ignore_for_file: unused_import

import 'package:eshop/firebase_options.dart';
import 'package:eshop/provider/cart_provider.dart';
import 'package:eshop/provider/product_provider.dart';
import 'package:eshop/vender/views/auth/vender_login_screen.dart';
import 'package:eshop/vender/views/screens/main_vender_screen.dart';
import 'package:eshop/vender/views/screens/upload_screen.dart';
import 'package:eshop/vender/views/screens/upload_tab_screen/general_tab_screen.dart';
import 'package:eshop/views/buyers/auth/buyer_login_screen.dart';
import 'package:eshop/views/buyers/auth/buyer_register_screen.dart';
import 'package:eshop/views/buyers/main_screen.dart';
import 'package:eshop/views/buyers/nav_screen/account_screen.dart';
import 'package:eshop/views/buyers/nav_screen/cart_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) {
        return ProductProvider();
      }),

       ChangeNotifierProvider(create: (_) {
        return CartProvider();
      })
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Brand-Bold",
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: VenderLoginScreen(),
      builder: EasyLoading.init(),
    );
  }
}
