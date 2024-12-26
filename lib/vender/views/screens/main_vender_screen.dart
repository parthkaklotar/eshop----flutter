// ignore_for_file: unnecessary_import, use_build_context_synchronously, prefer_final_fields

import 'package:eshop/vender/views/screens/earning_screen.dart';
import 'package:eshop/vender/views/screens/edit_product_screen.dart';
import 'package:eshop/vender/views/screens/upload_screen.dart';
import 'package:eshop/vender/views/screens/vender_logout_screen.dart';
import 'package:eshop/vender/views/screens/vender_order_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainVenderScreen extends StatefulWidget {
   const MainVenderScreen({super.key});

  @override
  State<MainVenderScreen> createState() => _MainVenderScreenState();
}

class _MainVenderScreenState extends State<MainVenderScreen> {
  int _pageIndex = 0;


  List<Widget> _pages= [
    const EarningScreen(),
          UploadScreen(),
    const EditProductScreen(),
     VenderOrderScreen(),
    VenderLogoutScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: (value) {
        setState(() {
          _pageIndex = value;
        });
        },
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.blue.shade900,
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          const BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.money_dollar,),
              label: 'Earnings',
          ),
           const BottomNavigationBarItem(
            icon: Icon(
              Icons.upload),
              label: 'Uplod',
          ),
           const BottomNavigationBarItem(
            icon: Icon(
              Icons.edit),
              label: 'Edit',
          ),
           const BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.shopping_cart),
              label: 'Orders',
          ),
           const BottomNavigationBarItem(
            icon: Icon(
              Icons.logout),
              label: 'Logout',
          ),
        ],
      ),

      body: _pages[_pageIndex],
    );
  }
}
