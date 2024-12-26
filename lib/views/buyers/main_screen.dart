// ignore_for_file: deprecated_member_use

import 'package:eshop/views/buyers/nav_screen/account_screen.dart';
import 'package:eshop/views/buyers/nav_screen/cart_screen.dart';
import 'package:eshop/views/buyers/nav_screen/category_screen.dart';
import 'package:eshop/views/buyers/nav_screen/home_screen.dart';
import 'package:eshop/views/buyers/nav_screen/search_screen.dart';
import 'package:eshop/views/buyers/nav_screen/store_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _pageIndex = 0;

  // ignore: prefer_final_fields
  List<Widget> _pages = [
    HomeScreen(),
    CategoryScreen(),
    StoreScreen(),
    CartScreen(),
    SearchScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _pageIndex,
          onTap: (value) => {
            setState(
              () {
                _pageIndex = value;
              },
            ),
          },
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.yellow.shade900,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/explore.svg',
                color: _pageIndex==1 ? Colors.yellow.shade900 : Colors.black,
              ),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/shop.svg',
                 color: _pageIndex==2 ? Colors.yellow.shade900 : Colors.black,
              ),
              label: 'Store',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/cart.svg',
                 color: _pageIndex==3 ? Colors.yellow.shade900 : Colors.black,
              ),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/search.svg',
                 color: _pageIndex==4 ? Colors.yellow.shade900 : Colors.black,
              ),
              label: 'Search ',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/account.svg',
                 color: _pageIndex==5 ? Colors.yellow.shade900 : Colors.black,
              ),
              label: 'Profile',
            ),
          ],
        ),
        body: _pages[_pageIndex],
      ),
    );
  }
}
