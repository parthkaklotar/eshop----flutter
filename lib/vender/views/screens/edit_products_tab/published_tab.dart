import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/vender/views/screens/vender_product_detail_screen/vender_product_detail_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class PublishedTab extends StatelessWidget {
  PublishedTab({super.key});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productStream = FirebaseFirestore.instance
      .collection('products')
      .where('venderId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .where('approved', isEqualTo: true)
      .snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _productStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return Container(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final vendorProductData = snapshot.data!.docs[index];
              return Slidable(
                child:   InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return VenderProductDetailScreen(productData: vendorProductData,);
                    },));
                  },
                  child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        child: Image.network(vendorProductData['imageUrlList'][0]),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              vendorProductData['productName'],
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '\₹' + ' ' +vendorProductData['productPrice'].toString(),
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                                ),
                ),
                // Specify a key if the Slidable is dismissible.
                key: const ValueKey(0),

                // The start action pane is the one at the left or the top side.
                startActionPane: ActionPane(
                  // A motion is a widget used to control how the pane animates.
                  motion: const ScrollMotion(),

                  // A pane can dismiss the Slidable.
                  dismissible: DismissiblePane(onDismissed: () {}),

                  // All actions are defined in the children parameter.
                  children:  [
                    // A SlidableAction can have an icon and/or a label.
                    SlidableAction(
                      flex: 2,
                      onPressed: (context) async{
                        await _firestore
                        .collection('products')
                        .doc(vendorProductData['productId'])
                        .update({
                          'approved': false,
                        });
                      },
                      backgroundColor: Color(0xFF21B7CA),
                      foregroundColor: Colors.white,
                      icon: Icons.approval_rounded,
                      label: 'Unpublished',
                    ),
                    SlidableAction(
                      flex: 2,
                       onPressed: (context) async{
                        await _firestore
                        .collection('products')
                        .doc(vendorProductData['productId'])
                        .delete();
                      },
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
