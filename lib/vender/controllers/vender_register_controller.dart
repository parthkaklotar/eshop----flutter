import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class VenderController {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to store image in storage
  _uploadVenderImageToStorage(Uint8List? image) async {
    Reference ref =
        _storage.ref().child('storageImage').child(_auth.currentUser!.uid);

    UploadTask uploadTask = ref.putData(image!);
    TaskSnapshot snapshot = await uploadTask;
    String downloadURl = await snapshot.ref.getDownloadURL();

    return downloadURl;
  }

  // Function to store record in collection

  // Function to pick image
  pickStoreImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();

    XFile? _file = await _imagePicker.pickImage(source: source);

    if (_file != null) {
      return await _file.readAsBytes();
    } else {
      print('No Image Selected');
    }
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

   _uploadProfileImageToStorage(Uint8List? image) async{
    Reference ref = _storage.ref().child('profilePics').child(_auth.currentUser!.uid);

    UploadTask uploadTask = ref.putData(image!);

    TaskSnapshot Snapshot = await uploadTask;

    String downloadURL = await Snapshot.ref.getDownloadURL(); 

    return downloadURL;
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
  


 Future <String> registervender(
    String businessName,
    String email,
    String phoneNumber,
    String countryValue,
    String stateValue,
    String cityValue,
    String taxRagistered,
    String taxNumber,
    Uint8List? image,
  ) 
  async{
    String res = 'Some error occured';

    try {
        String storageImage =  await _uploadVenderImageToStorage(image);
        await _firestore
        .collection('venders')
        .doc(_auth.currentUser!.uid)
        .set({
          'businessName': businessName,
          'email': email,
          'phoneNumber': phoneNumber,
          'cityValue' : cityValue,
          'countryValue': countryValue,
          'stateValue': stateValue,
          'taxRagistered': taxRagistered,
          'taxNumber': taxNumber,
          'storageImage' : storageImage,
          'approved' : false,
          'venderId' : _auth.currentUser!.uid,
        });
    } catch (e) {
      res = e.toString();
    }

    return res;
  }
}
