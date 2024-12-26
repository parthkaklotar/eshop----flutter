import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class VenderLogoutScreen extends StatelessWidget {
  VenderLogoutScreen({super.key});

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          _auth.signOut();
        },
        child: Text('Signout'),
      ),
    );
  }
}
