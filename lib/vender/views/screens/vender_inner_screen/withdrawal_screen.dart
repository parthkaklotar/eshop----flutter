import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/utils/show_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class WithdrawalScreen extends StatelessWidget {
      WithdrawalScreen({super.key});

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late String amount;
  late String name;
  late String mobile;
  late String bankName;
  late String bankAccountName;
  late String bankAccountNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        elevation: 0,
        title: const Text(
          'Withdraw',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 3,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'Amount Must Not Be Empty!';
                    }else{
                      return null;
                    }
                  },
                  onChanged: (value) {
                    amount = value;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                   validator: (value) {
                    if(value!.isEmpty){
                      return 'Amount Must Not Be Empty!';
                    }else{
                      return null;
                    }
                   },
                  onChanged: (value) {
                    name = value;
                  },
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                   validator: (value) {
                    if(value!.isEmpty){
                      return 'Mobile No. Must Not Be Empty!';
                    }else{
                      return null;
                    }
                   },
                  onChanged: (value) {
                    mobile = value;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Mobile',
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                   validator: (value) {
                    if(value!.isEmpty){
                      return 'Bank Name Must Not Be Empty!';
                    }else{
                      return null;
                    }
                   },
                  onChanged: (value) {
                    bankName = value;
                  },
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Bank Name',
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                   validator: (value) {
                    if(value!.isEmpty){
                      return 'Bank A/c Name Must Not Be Empty!';
                    }else{
                      return null;
                    }
                   },
                  onChanged: (value) {
                    bankAccountName = value;
                  },
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Bank Account Name',
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                   validator: (value) {
                    if(value!.isEmpty){
                      return 'Bank A/C NO. Must Not Be Empty!';
                    }else{
                      return null;
                    }
                   },
                  onChanged: (value) {
                    bankAccountNumber = value;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Bank Account Number',
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () async{
                    if(_formkey.currentState!.validate()){
                      EasyLoading.show(status: "Sending Request...");

                      await _firestore
                      .collection('withdrawal')
                      .doc(Uuid().v4())
                      .set({
                        'Amount' : amount,
                        'Name'   : name,
                        'Mobile' : mobile,
                        'Bank Name': bankName,
                        'BankAccountName' : bankAccountName,
                        'BankAcoount Number' : bankAccountNumber,
                        'venderId' : FirebaseAuth.instance.currentUser!.uid,
                      }).whenComplete(() {
                        EasyLoading.dismiss();
                        showsnack(context, 'Withdrawal Request is Sent', Colors.green.shade900);
                      });

                      print('Done');
                    }else{
                      EasyLoading.dismiss();
                        showsnack(context, 'Withdrawal Request is not Sent', Colors.red.shade900);
                      print('Not Done');
                    }
                  },
                  child: const Text(
                    'Get Cash',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}