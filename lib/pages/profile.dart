import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottery/pages/auth/firebase_core.dart';
import 'package:lottery/pages/getTicktNumber.dart';
import 'package:lottery/pages/setting.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final _uid = FirebaseAuth.instance.currentUser!.uid;

// ignore: camel_case_types
class _ProfilePageState extends State<ProfilePage> {
  Future<String?> fetchCurrentUsername(String datas) async {
    final DocumentSnapshot<Map<String, dynamic>> document =
        await _firestore.collection('users').doc(_uid).get();
    if (document.exists) {
      final Map<String, dynamic> userData = document.data()!;
      return userData[datas];
    } else {
      return null;
    }
  }

  final currentUser = FirebaseAuth.instance.currentUser;
  String _phoneNumberText = '';
  String _usernameText = '';

  Future<void> _fetchAndDisplayUserInfo() async {
    final String? username = await fetchCurrentUsername('name');
    final String? phoneNumber = await fetchCurrentUsername('phone');
    setState(() {
      _phoneNumberText = phoneNumber ?? '';
      _usernameText = username ?? '';
    });
  }

  // firebase current user

  @override
  void initState() {
    super.initState();
    _fetchAndDisplayUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      bottomNavigationBar: Container(
        height: 50,
        child: MaterialButton(
          onPressed: () {
            AuthService().LogOut(context: context);
          },
          child: const Center(
            child: Text(
              'LOGOUT',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 70, 70), fontSize: 20),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('images/face1.jpg'),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '$_usernameText',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text('${currentUser?.email}'),
                    Text(
                      '$_phoneNumberText',
                    ),
                    const SizedBox(height: 20),
                    ListTile(
                        leading: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SettingPage()));
                          },
                          icon: const Icon(Icons.settings),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SettingPage()));
                          },
                          icon: const Icon(Icons.edit),
                        )),
                  ],
                ),
              ),
            ),
            MaterialButton(
                padding: EdgeInsets.all(20),
                onPressed: () {
                  // navigate to home page
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const Getticket();
                    },
                  ));
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.call_to_action_outlined),
                    SizedBox(width: 8),
                    Text(
                      'MY  TICKETS',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
