import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/vender/views/screens/vender_inner_screen/withdrawal_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EarningScreen extends StatelessWidget {
  const EarningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference venders =
        FirebaseFirestore.instance.collection('venders');
     final Stream<QuerySnapshot> _ordersStream = 
        FirebaseFirestore.instance.collection('orders')
        .where('vender', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();

    return FutureBuilder<DocumentSnapshot>(
      future: venders.doc(FirebaseAuth.instance.currentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              title: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(data['storageImage']),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.00),
                    child: Text(
                      'Hi ' + data['businessName'],
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        letterSpacing: 3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: StreamBuilder<QuerySnapshot>(
              stream: _ordersStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                double totalOrders = 0.0;
                for(var  orderItem in snapshot.data!.docs){
                  totalOrders += orderItem['quantity'] * orderItem['productPrice'];
                }

                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      children: [
                        Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width * 0.5,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade900,
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 30,),
                              Text(
                                'TOTAL EARNINGS',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  '\$' + " " + totalOrders.toStringAsFixed(2),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                ),
                            ],
                          ),
                        ),

                        SizedBox(height: 40,),

                        Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width * 0.5,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade900,
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 30,),
                              Text(
                                'TOTAL ORDERS',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  snapshot.data!.docs.length.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(height: 70,),

                        InkWell(
                           onTap:() {
                             Navigator.push(context, MaterialPageRoute(builder: (context) {
                               return WithdrawalScreen();
                             },),);
                           }, 
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width -40,
                            decoration: BoxDecoration(
                              color: Colors.green.shade900,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                'Withdraw',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 3,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                );
              },
            ),
          );
        }

        return Center(
          child: LinearProgressIndicator(
            color: Colors.blue.shade900,
          ),
        );
      },
    );
  }
}
