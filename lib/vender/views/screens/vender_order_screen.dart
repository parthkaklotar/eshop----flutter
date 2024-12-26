// ignore_for_file: depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class VenderOrderScreen extends StatelessWidget {
   VenderOrderScreen({super.key});

  String formatedDate(date) {
    final outputDateFormat = DateFormat('dd/MM/yyyy');
    final outputDate = outputDateFormat.format(date);
    return outputDate;
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final Stream<QuerySnapshot> _orderStream = FirebaseFirestore.instance
        .collection('orders')
        .where('vender', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        elevation: 0,
        title: const Text(
          'My Orders',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _orderStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blue.shade900,
              ),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              return Slidable(
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 14,
                          child: document['accepted'] == true
                              ? const Icon(Icons.delivery_dining)
                              : const Icon(Icons.access_time)),
                      title: document['accepted'] == true
                          ? Text(
                              'Accepted',
                              style: TextStyle(
                                color: Colors.blue.shade900,
                              ),
                            )
                          : Text(
                              'Not Accepted',
                              style: TextStyle(
                                color: Colors.red.shade900,
                              ),
                            ),
                      trailing: Text(
                        // ignore: prefer_adjacent_string_concatenation
                        '₹' + ' ' + document['productPrice'].toStringAsFixed(2),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 17,
                        ),
                      ),
                      subtitle: Text(
                        formatedDate(document['orderDate'].toDate()),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    ExpansionTile(
                      title: Text(
                        'Order Details',
                        style: TextStyle(
                          color: Colors.blue.shade900,
                          fontSize: 15,
                        ),
                      ),
                      subtitle: const Text(
                        'View Order Details',
                      ),
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            child: Image.network(
                              document['productImage'][0],
                            ),
                          ),
                          title: Text(document['productName']),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Text(
                                    'Quantity',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    document['quantity'].toString(),
                                  ),
                                ],
                              ),
                              document['accepted'] == true
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Text('Schedule Delivery Date'),
                                        Text(
                                          formatedDate(
                                              document['orderDate'].toDate()),
                                        ),
                                      ],
                                    )
                                  : const Text(''),
                              ListTile(
                                title: const Text(
                                  'Buyer Details',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(document['fullName']),
                                    Text(document['email']),
                                    Text(document['address']),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              
                startActionPane: ActionPane(
                  motion: const ScrollMotion(),

                  children:  [
                    SlidableAction(
                      onPressed: (context) async{
                        await _firestore
                        .collection('orders')
                        .doc(document['orderId'])
                        .update({
                          'accepted' : false,
                        });
                      },
                      backgroundColor: Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Reject',
                    ),
                    SlidableAction(
                      onPressed: (context) async{
                        await _firestore
                        .collection('orders')
                        .doc(document['orderId'])
                        .update({
                          'accepted' : true,
                        });
                      },
                      backgroundColor: Color(0xFF21B7CA),
                      foregroundColor: Colors.white,
                      icon: Icons.share,
                      label: 'Accept',
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
