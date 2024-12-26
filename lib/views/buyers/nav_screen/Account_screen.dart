// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/views/buyers/auth/buyer_login_screen.dart';
import 'package:eshop/views/buyers/inner_screens/customer_order_screen.dart';
import 'package:eshop/views/buyers/inner_screens/edit_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
   AccountScreen({super.key});
  
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('buyers');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.blue.shade900,
        title: const Text(
          'Proflie',
          style: TextStyle(
            letterSpacing: 4,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Icon(
              Icons.star,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 64,
            backgroundColor: Colors.blue.shade900,
            backgroundImage: NetworkImage(data['profileImage']),
          ),
           const SizedBox(height: 15,),
           Text(
            data['fullName'],
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
           Text(
           data['email'],
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Divider(
              thickness: 2,
              color: Color.fromRGBO(76, 175, 80, 1),
            ),
          ),
          InkWell(
            onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                       return  EditProfileScreen(userData: data,);
                     },));
            },
            child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width - 200,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade900,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
          const ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
           const ListTile(
            leading: Icon(Icons.phone),
            title: Text('Phone'),
          ),
           const ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Cart'),
          ), 
           ListTile(
             onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                 return  CustomerOrderScreen(); 
                }),);
             },
            
            leading: Icon(Icons.shopping_bag),
            title: Text('Orders'),
          ),
            ListTile(
            onTap: () async{
               await _auth.signOut().whenComplete(() {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                 return const BuyerLoginScreen(); 
                }),);
               },);
            },
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
          ),
        ],
      ),
    );
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
