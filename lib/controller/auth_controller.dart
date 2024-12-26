// ignore_for_file: unused_local_variable, empty_catches, unused_element, unused_import
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  _uploadProfileImageToStorage(Uint8List? image) async{
    Reference ref = _storage.ref().child('profilePics').child(_auth.currentUser!.uid);

    UploadTask uploadTask = ref.putData(image!);

    TaskSnapshot Snapshot = await uploadTask;

    String downloadURL = await Snapshot.ref.getDownloadURL(); 

    return downloadURL;
  }

  pickprofileimage(ImageSource source)async{
    final ImagePicker _imagePicker = ImagePicker();

    XFile? _file = await _imagePicker.pickImage(source: source);

    if(_file!= null){
      return await _file.readAsBytes();
    }else{
      print('No Image Selected');
    }
  }

  Future<String> signUpUsers(
    String email,
    String fullName,
    String phoneNumber,
    String password,
    Uint8List? image,
  ) async {
    String res = 'Some error occured';

    try {
      if (email.isNotEmpty &&
          fullName.isNotEmpty &&
          phoneNumber.isNotEmpty &&
          password.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String profileImageURl = await _uploadProfileImageToStorage(image);

        await _firestore.collection("buyers").doc(cred.user!.uid).set({
              'buyerid': cred.user!.uid,
              'email': email,
              'fullName' : fullName,
              'phoneNumber': phoneNumber,
              'address' : '',
              'profileImage': profileImageURl,
          }
        );

        res = 'success'; 
      } else {
        res = 'All fields must be filled';
      }
    } catch (e) {}

    return res;
  }
  
  loginUsers(String email, String password)  async {
    String res = 'Something Went Wrong'; 

    try{
      if(email.isNotEmpty && password.isNotEmpty){
        await _auth.signInWithEmailAndPassword(email: email, password: password);

       res = 'success';
      }else{
        res = 'Something Wrong';
      }
    }catch(e){
      res = 'User Or Password is not Valid';  //e.toString();
    }
    return res;
  }
}
