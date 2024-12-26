// ignore_for_file: unnecessary_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/provider/product_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class GeneralTabScreen extends StatefulWidget {
  const GeneralTabScreen({super.key});

  @override
  State<GeneralTabScreen> createState() => _GeneralTabScreenState();
}

class _GeneralTabScreenState extends State<GeneralTabScreen>
  with AutomaticKeepAliveClientMixin {
  
  @override
  bool get wantKeepAlive => true;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<String> _categoryList = [];

  _getCategories() {
    return _firestore.collection('categories').get().then(
      (QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          setState(() {
            _categoryList.add(
              doc['categoryName'],
            );
          });
        }
      },
    );
  }

  @override
  void initState() {
    _getCategories();
    super.initState();
  }

  String formatDate(date) {
    final outputDateFormat = DateFormat('dd/MM/yyyy');
    final outputDate = outputDateFormat.format(date);
    return outputDate;
  }

  @override
  Widget build(BuildContext context) { 
    super.build(context);
    final ProductProvider _productprovider =
        Provider.of<ProductProvider>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                validator: (value){
                  if(value!.isEmpty){
                    return 'Enter Product Name';
                  }else{
                    return null;
                  }
                },
                onChanged: (value) {
                  _productprovider.getFormData(productName: value);
                },
                decoration: const InputDecoration(
                  labelText: 'Enter Product Name',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value){
                  if(value!.isEmpty){
                    return 'Enter Product Price';
                  }else{
                    return null;
                  }
                },
                onChanged: (value) {
                  _productprovider.getFormData(
                    productPrice: double.parse(value),
                  );
                },
                decoration: const InputDecoration(
                  labelText: 'Enter Product Price',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value){
                  if(value!.isEmpty){
                    return 'Enter Product Quantity';
                  }else{
                    return null;
                  }
                },
                onChanged: (value) {
                  _productprovider.getFormData(
                    quantity: int.parse(value),
                  );
                },
                decoration: const InputDecoration(
                  labelText: 'Enter Product Quantity',
                ),
              ),
              DropdownButtonFormField(
                hint: const Text('Select Category'),
                items: _categoryList.map<DropdownMenuItem<String>>((e) {
                  print(_categoryList.length);
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  );
                }).toList(),
                onChanged: (value) {
                  _productprovider.getFormData(
                    category: (value),
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                validator: (value){
                  if(value!.isEmpty){
                    return 'Enter Product Descriptions';
                  }else{
                    return null;
                  }
                },
                onChanged: (value) {
                  _productprovider.getFormData(
                    descriptions: (value),
                  );
                },
                maxLines: 10,
                maxLength: 800,
                decoration: InputDecoration(
                  labelText: 'Enter Product Descriptions',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(5000),
                      ).then((value) {
                        _productprovider.getFormData(scheduleDate: value);
                      });
                    },
                    child: Text('Schedule'),
                  ),
                  if(_productprovider.productData['scheduleDate'] != null)
                  Text(
                    formatDate(
                      _productprovider.productData['scheduleDate'],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
