import 'package:eshop/views/buyers/nav_screen/Widget/banner_widget.dart';
import 'package:eshop/views/buyers/nav_screen/Widget/category_text.dart';
import 'package:eshop/views/buyers/nav_screen/Widget/search_input_screen.dart';
import 'package:eshop/views/buyers/nav_screen/Widget/welcome_Text_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WelcomeText(),
          SizedBox(
            height: 14,
          ),
          SearchInput(),
          BannerWidget(),
          CategoryText(),
        ],
      ),
    );
  }
}

