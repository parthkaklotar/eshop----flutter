// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/provider/product_provider.dart';
import 'package:eshop/vender/views/screens/images_tab_screen.dart';
import 'package:eshop/vender/views/screens/main_vender_screen.dart';
import 'package:eshop/vender/views/screens/upload_tab_screen/attributes_tab_screen.dart';
import 'package:eshop/vender/views/screens/upload_tab_screen/general_tab_screen.dart';
import 'package:eshop/vender/views/screens/upload_tab_screen/shipping_tab_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class UploadScreen extends StatelessWidget {
  UploadScreen({super.key});

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final ProductProvider _productprovider =
        Provider.of<ProductProvider>(context);

    return DefaultTabController(
      length: 4,
      child: Form(
        key: _formkey,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            bottom: const TabBar(
              tabs: [
                Tab(
                  child: Text('General'),
                ),
                Tab(
                  child: Text('Shiping'),
                ),
                Tab(
                  child: Text('Attributes'),
                ),
                Tab(
                  child: Text('Images'),
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              GeneralTabScreen(),
              ShippingTabScreen(),
              AttributesTabScreen(),
              ImagesTabScreen(),
            ],
          ),
          bottomSheet: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade900,
              ),
              onPressed: () async {
                if (_formkey.currentState!.validate()) {
                EasyLoading.show(status: 'Please Wait...');
                final productId = Uuid().v4();

                
              print(productId);
                  print(_productprovider.productData['productName'],);
                  print(_productprovider.productData['productPrice'],);
                  print(_productprovider.productData['quantity'],);
                  print(_productprovider.productData['category'],);
                  print(_productprovider.productData['descriptions'],);
                  print(_productprovider.productData['scheduleDate'],);
                  print(_productprovider.productData['imageUrlList'],);
                  print(_productprovider.productData['chargeShipping'],);
                  print(_productprovider.productData['shippingCharge'],);


                  await _firestore.collection('products').doc(productId).set({
                    'productId': productId,
                    'productName': _productprovider.productData['productName'],
                    'productPrice':
                        _productprovider.productData['productPrice'],
                    'quantity': _productprovider.productData['quantity'],
                    'category': _productprovider.productData['category'],
                    'descriptions':
                        _productprovider.productData['descriptions'],
                    'scheduleDate':
                        _productprovider.productData['scheduleDate'],
                    'imageUrlList':
                        _productprovider.productData['imageUrlList'],
                    'chargeShipping':
                        _productprovider.productData['chargeShipping'],
                    'shippingCharge':
                        _productprovider.productData['shippingCharge'],
                    'brandName': _productprovider.productData['brandName'],
                    'sizeList': _productprovider.productData['sizeList'],
                    'venderId': FirebaseAuth.instance.currentUser!.uid,
                    'approved': false,
                  },
                  ).whenComplete(() {
                    _productprovider.clearData();
                    _formkey.currentState!.reset();

                    EasyLoading.dismiss();
 
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return MainVenderScreen();
                        },
                      ),
                    );
                  });
                }
              },
              child: const Text('Save'),
            ),
          ),
        ),
      ),
    );
  }
}
