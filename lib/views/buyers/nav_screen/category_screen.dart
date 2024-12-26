import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/views/buyers/inner_screens/all_product_screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
   CategoryScreen({super.key});

   final Stream<QuerySnapshot> _categoryStream = FirebaseFirestore.instance.collection('categories').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          'Categories',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
      stream: _categoryStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: Colors.blue.shade900,),
          );
        }

        return Container(
          height: 250,
          child: ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final categoryData = snapshot.data!.docs[index];

              return ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                   return AllProductScreen(categoryData: categoryData,); 
                  }),);
                },
                leading: (categoryData['image']!= null) 
                ?Image.network(categoryData['image'])
                :Icon(Icons.image),
                title: Text(
                  categoryData['categoryName'],
                ),
              );
            }, 
            ),
        );
      },
    ),
    );
  }
}
