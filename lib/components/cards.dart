// ignore_for_file: depend_on_referenced_packages


import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:lottery/pages/games/number.dart';
import 'package:lottery/pages/profile.dart';
import 'package:slide_countdown/slide_countdown.dart';

class CardList extends StatelessWidget {
  const CardList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  SizedBox(width: 10),
                  Icon(
                    Icons.filter_list,
                    size: 34,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Winner list",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.chevron_right_sharp))
            ],
          ),
          const ContactCard(
              name: 'John Doe',
              tiketNumber: '53524 - 20/20/23',
              buttonColor: Colors.green,
              buttonText: 'show more'),
          const ContactCard(
              name: 'Sir James',
              tiketNumber: '53524- 20/20/23',
              buttonColor: Colors.orange,
              buttonText: 'show more'),
          const ContactCard(
              name: 'Jimmy',
              tiketNumber: '53524- 20/20/23',
              buttonColor: Colors.blue,
              buttonText: 'show more'),
          const ContactCard(
              name: 'sad Smith',
              tiketNumber: '53524- 20/20/23',
              buttonColor: Colors.blue,
              buttonText: 'show more'),
        ],
      ),
    );
  }
}

class ContactCard extends StatelessWidget {
  final String name;
  final String tiketNumber;
  final Color buttonColor;
  final String buttonText;

  const ContactCard(
      {super.key,
      required this.name,
      required this.tiketNumber,
      required this.buttonColor,
      required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.person),
        ),
        title: Text(name),
        subtitle: Text(tiketNumber),
        trailing: TextButton(
          onPressed: () {},
          child: Text(buttonText),
        ),
      ),
    );
  }
}

class FirstCard extends StatefulWidget {
  const FirstCard({super.key});

  @override
  State<FirstCard> createState() => _FirstCardState();
}

class _FirstCardState extends State<FirstCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 270,
      decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background.jpeg"),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      margin:
          const EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedTextKit(
                  animatedTexts: [
                    ColorizeAnimatedText(
                        speed: const Duration(seconds: 1),
                        " ET1000",
                        textStyle: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                        colors: const [
                          Color.fromARGB(255, 255, 255, 255),
                          Color.fromARGB(255, 255, 0, 242),
                          Color.fromARGB(255, 255, 255, 255),
                        ])
                  ],
                  repeatForever: true,
                  isRepeatingAnimation: true,
                ),
                MaterialButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NumberScreen(),
                          ));
                    },
                    child: Container(
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Color.fromARGB(255, 58, 183, 255),
                              Color.fromARGB(255, 212, 0, 255),
                            ]),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        width: 150,
                        height: 45,
                        child: const Center(
                            child: SizedBox(
                          width: 250.0,
                          child: Center(
                            child: Text(
                              'Play Now',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 23),
                            ),
                          ),
                        ))))
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 16, 1, 153),
                    Color.fromARGB(255, 241, 0, 212)
                  ]),
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SlideCountdown(
                      duration: const Duration(hours: 12),
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                      onDone: () {
                        //navigate to the profile page
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProfilePage()));
                      },
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
