import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/views/buyers/product_details/product_detail_screen.dart';
import 'package:flutter/material.dart';

class HomeProductWidget extends StatelessWidget {
  const HomeProductWidget({super.key, required this.categoryName});

  final String? categoryName;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productStream = FirebaseFirestore.instance
        .collection('products')
        .where('category', isEqualTo: categoryName)
        .where('approved', isEqualTo: true)
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _productStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return Container(
          height: 250,
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 200 / 300,
              ),
              itemCount: snapshot.data!.size,
              itemBuilder: (context, index) {
                 final productData = snapshot.data!.docs[index];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return ProductDetailScreen(productData: productData,);
                    },),);
                  },
                  child: Card(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: 170,
                            width: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  productData['imageUrlList'][0],
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                            productData['productName'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                            ),
                          ),
                            Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                            '\₹' + ' ' + productData['productPrice'].toStringAsFixed(2),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
        );
      },
    );
  }
}
