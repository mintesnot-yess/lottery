import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lottery/components/cards.dart';
import 'package:lottery/firebase_options.dart';
import 'package:lottery/pages/auth/signin.dart';
import 'package:lottery/pages/auth/signup.dart';
import 'package:lottery/pages/notification.dart';
import 'package:lottery/pages/profile.dart';
import 'package:lottery/pages/setting.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

// void main() {
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lottery app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 34, 34, 34)),
        useMaterial3: true,
      ),
      home: FirebaseAuth.instance.currentUser?.email != null
          ? const Home()
          : SignInScreen(),
      routes: {
        '/home': (context) => const Home(),
        '/profile': (context) => const ProfilePage(),
        '/setting': (context) => const SettingPage(),
        '/login': (context) => const SignInScreen(),
        '/signup': (context) => SignUpScreen(),
        '/notification': (context) => const NotificationPage(),
      },
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

int currentIndex = 1;
var dt = DateTime.now();

//flutter current user
final currentUser = FirebaseAuth.instance.currentUser;

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const CircleAvatar(
              backgroundImage: AssetImage('images/face1.jpg'),
            ),
            onPressed: () {
              setState(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfilePage()));
              });
            },
          ),
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   '100',
              //   style: TextStyle(
              //       color: Colors.black54,
              //       fontSize: 20,
              //       fontWeight: FontWeight.bold),
              // ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications,
                  color: Color.fromARGB(255, 82, 82, 82)),
              onPressed: () {
                Navigator.pushNamed(context, '/notification');
              },
            ),
          ],
        ),
        body: const SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [FirstCard(), CardList()],
            ),
          ),
        ));
  }
}
