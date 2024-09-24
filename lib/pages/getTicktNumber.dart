import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Getticket extends StatefulWidget {
  const Getticket({super.key});

  @override
  State<Getticket> createState() => _GetticketState();
}

final _uid = FirebaseAuth.instance.currentUser!.uid;

class _GetticketState extends State<Getticket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tickets'),
        actions: [
          TextButton(onPressed: () {}, child: const Text('clear all data'))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('ticket')
                    .where('user_id', isEqualTo: _uid)
                    .snapshots(),
                builder: (context, snapshat) {
                  List<Row> ticketWidget = [];
                  if (snapshat.hasData) {
                    for (var doc in snapshat.data!.docs) {
                      var ticket = doc.data();
                      ticketWidget.add(Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 10),
                              const Icon(Icons.call_to_action_outlined),
                              const SizedBox(width: 10),
                              Text(
                                ticket['ticket-number'].toString(),
                                style: const TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              // navigate to home page
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) {
                              //       return const Getticket();
                              //     },
                              //   ),
                              // );
                            },
                            child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: const Text('Result')),
                          ),
                        ],
                      ));
                    }
                  } else {
                    return const CircularProgressIndicator();
                  }

                  if (ticketWidget.isEmpty) {
                    return const Text(
                      'No tickets found',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    );
                  }
                  return Expanded(
                    child: ListView(
                      children: ticketWidget,
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
