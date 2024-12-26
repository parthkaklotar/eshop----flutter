// ignore_for_file: unused_import, unnecessary_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/vender/views/auth/vender_signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eshop/vender/models/vender_user_models.dart';
import 'package:eshop/vender/views/auth/vender_register_screen.dart';
import 'package:eshop/vender/views/screens/main_vender_screen.dart';

class LandingScreen extends StatelessWidget {
  LandingScreen({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _venderStream =
      FirebaseFirestore.instance.collection('venders');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: _venderStream.doc(_auth.currentUser!.uid).snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading"); 
          }

          if(!snapshot.data!.exists){
            return const VenderSignUpScreen();
          }

          VenderUserModel venderUserModel = VenderUserModel.fromJson(
              snapshot.data!.data()! as Map<String, dynamic>);

          if(venderUserModel.approved == true){
            return  MainVenderScreen();
          }

          return Center(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    venderUserModel.storageImage.toString(),
                    width: 90,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 15,
                  ),

                Text(
                  venderUserModel.businessName.toString(),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10,),
                const Text(
                  'Your application has been sent to admin. Admin will get back to you soon',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                 const SizedBox(height: 10,),
                 TextButton(
                  onPressed: () async{
                    await _auth.signOut();
                  }, 
                  child: const Text('Singout'),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
