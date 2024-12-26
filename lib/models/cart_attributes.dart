import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class CartAttr with ChangeNotifier {
  final String productName;
  final String productId;
  final List imageUrlList;
  int quantity;
  int productQuantity;
  final double price;
  final String venderId;
  final String productSize;

  Timestamp scheduleDate;

  CartAttr({
  required  this.productName,
  required  this.productId,
  required  this.imageUrlList,
  required  this.quantity,
  required  this.productQuantity,
  required  this.price,
  required  this.venderId,
  required  this.productSize,
  required  this.scheduleDate, 
  }
  );

   void increse(){
    quantity++;
   }
   void decrease(){
    quantity--;
   }
}
