import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottery/pages/setting.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

// ignore: camel_case_types
class _ProfilePageState extends State<ProfilePage> {
  // firebase current user
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(16.0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('images/face1.jpg'),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Mintesnot yesmashewa',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      '${currentUser?.email}',
                    ),
                    const Text('+2519 034567'),
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
            Column(
              children: [
                const Text(
                  'My Tikets ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Card(
                  child: ListTile(
                    title: const Row(
                      children: [
                        Icon(Icons.call_to_action_outlined),
                        Padding(padding: EdgeInsets.all(2)),
                        Text('121212', style: TextStyle(fontSize: 20))
                      ],
                    ),
                    trailing: TextButton(
                      onPressed: () {},
                      child: const Text('Result'),
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: const Row(
                      children: [
                        Icon(Icons.call_to_action_outlined),
                        Padding(padding: EdgeInsets.all(2)),
                        Text('543222', style: TextStyle(fontSize: 20))
                      ],
                    ),
                    trailing: TextButton(
                      onPressed: () {},
                      child: const Text('Result'),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
