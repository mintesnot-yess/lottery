import 'package:flutter/material.dart';
import 'package:lottery/pages/auth/firebase_core.dart';
import 'package:lottery/pages/profile.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool _darkMode = false;
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
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
      body: ListView(
        children: [
          ListTile(
            title: const Text('Dark Mode'),
            trailing: Switch(
              value: _darkMode,
              onChanged: (value) {
                setState(() {
                  _darkMode = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Notifications'),
            trailing: Switch(
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Account'),
            onTap: () {
              // Navigate to profile page
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()));
            },
          ),
          ListTile(
            title: const Text('Help & Feedback'),
            onTap: () {
              // Navigate to help and feedback screen
            },
          ),
          ListTile(
            title: const Text('About'),
            onTap: () {
              // Navigate to about screen
            },
          ),
        ],
      ),
    );
  }
}
