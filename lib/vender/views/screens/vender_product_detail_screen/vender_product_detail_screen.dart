import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/utils/show_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VenderProductDetailScreen extends StatefulWidget {
  const VenderProductDetailScreen({super.key, this.productData});

  final dynamic productData;

  @override
  State<VenderProductDetailScreen> createState() => _VenderProductDetailScreenState();
}

class _VenderProductDetailScreenState extends State<VenderProductDetailScreen> {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _brandNameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productdescriptionsController = TextEditingController();
  final TextEditingController _categoryNameController = TextEditingController();

  @override
  void initState() {
    setState(() {
      _productNameController.text = widget.productData['productName'];
      _brandNameController.text = widget.productData['brandName'];
      _quantityController.text = widget.productData['quantity'].toString();
      _productPriceController.text = widget.productData['productPrice'].toString();
     _productdescriptionsController.text = widget.productData['descriptions'];
     _categoryNameController.text = widget.productData['category'];

    productPrice = double.parse(widget.productData['productPrice'].toString());
    productQuantity = int.parse(widget.productData['quantity'].toString());
    });
    super.initState();
  }
  
  double? productPrice;
  int? productQuantity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.blue.shade900,
        elevation: 0,
        title: Text(
          widget.productData['productName'],
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              controller: _productNameController,
              decoration: InputDecoration(
                labelText: 'product Name',
              ),
            ),
        
            SizedBox(height: 20,),
        
            TextFormField(
              controller: _brandNameController,
              decoration: InputDecoration(
                labelText: 'brand Name',
              ),
            ),
        
            SizedBox(height: 20,),
        
            TextFormField(
                onChanged: (value) {
                productQuantity = int.parse(value);
              },
              controller: _quantityController,
              decoration: InputDecoration(
                labelText: 'Quantity',
              ),
            ),
        
            SizedBox(height: 20,),
        
            TextFormField(
              onChanged: (value) {
                productPrice = double.parse(value);
              },
              controller: _productPriceController,
              decoration: InputDecoration(
                labelText: 'Price',
              ),
            ),
            
            SizedBox(height: 20,),
        
             TextFormField(
              maxLength: 800,
              maxLines: 3,
              controller: _productdescriptionsController,
              decoration: InputDecoration(
                labelText: 'Descriptions',
              ),
            ),
        
            SizedBox(height: 20,),
        
            TextFormField(
              controller: _categoryNameController,
              decoration: InputDecoration(
                labelText: 'Category',
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () async{

            if(productPrice != null && productQuantity != null){
            await _firestore
            .collection('products')
            .doc(widget.productData['productId'])
            .update({
              'productName': _productNameController.text,
              'brandName' :  _brandNameController.text,
              'quantity' :  productQuantity,
              'productPrice': productPrice,
              'descriptions': _productdescriptionsController.text,
              'category' : _categoryNameController.text,
            });
            showsnack(context, 'Updated Product Data', Colors.green.shade900);
            }else{
              showsnack(context, 'Updat is not done', Colors.red.shade900);
            }
          },
          child: Container(
            height: 40,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color:  Colors.blue.shade900,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'UPDATE PRODUCT', 
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}