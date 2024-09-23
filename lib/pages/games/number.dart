import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottery/main.dart';
import 'package:slide_countdown/slide_countdown.dart';

class NumberScreen extends StatefulWidget {
  const NumberScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NumberScreenState createState() => _NumberScreenState();
}

class _NumberScreenState extends State<NumberScreen> {
  List<int> selectedNumbers = [];
  final List<int> numbers = List.generate(10, (index) => index);


  @override
  void initState() {
    super.initState();
    _updateTime();
  }

  void _updateTime() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6654F2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            //back to home page
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.keyboard_arrow_left_outlined,
            color: Colors.white,
            size: 35,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
          color: Colors.white,
          onPressed: selectedNumbers.length == 5
              ? () {
                  // navigate to payment page
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PaymentScreen(selectedNumbers: selectedNumbers)));
                }
              : null,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Make a payment',
              style: TextStyle(
                  fontSize: 25,
                  color: Color.fromARGB(255, 55, 39, 175),
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Choose",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "5 numbers",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      color: selectedNumbers.isEmpty
                          ? const Color.fromARGB(92, 255, 255, 255)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        '${selectedNumbers.join(",")}',
                        style: const TextStyle(
                            color: Color(0xFF6654F2),
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const SlideCountdown(
                      duration: Duration(hours: 12),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),

                      
                      ),
               
              const SizedBox(height: 10),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: SizedBox(
                    width: 300,
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: numbers.length,
                      itemBuilder: (context, index) {
                        return _buildNumberButton(
                          numbers[index],
                          isSelected: selectedNumbers.contains(numbers[index]),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNumberButton(int number, {bool isSelected = false}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (selectedNumbers.contains(number)) {
            selectedNumbers.remove(number);
          } else if (selectedNumbers.length < 5) {
            selectedNumbers.add(number);
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromARGB(166, 163, 163, 163)
              : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Text(
            number.toString(),
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key, required List<int> selectedNumbers});

  @override
  // ignore: library_private_types_in_public_api
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6654F2),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF6654F2),
        ),
        child: Column(
          children: [
            _buildHeader(),
            _buildDetails(),
            _buildTotal(),
            _buildPayButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const SlideCountdown(
                      duration:  Duration(hours: 12),
                      decoration:  BoxDecoration(
                        color: Colors.transparent,
                      ),style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),

                      
                      ),
        ],
      ),
    );
  }

  Widget _buildDetails() {
    return Column(
      children: [
        const Text(
          'Payment',
          style: TextStyle(
              fontSize: 34, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Container(
          width: double.infinity,
          height: 300,
          margin: const EdgeInsets.symmetric(horizontal: 30),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color.fromARGB(162, 81, 65, 202),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSelectedNumbers(),
              _buildPossibleWinnings(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedNumbers() {
    // ignore: prefer_const_constructors
    return Column(
      children: const [
        Text(
          'Selected Numbers',
          style: TextStyle(
              fontSize: 19,
              color: Color.fromARGB(255, 187, 187, 187),
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          '2,3,4,5,6',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildPossibleWinnings() {
    return const Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          'Possible Winnings',
          style: TextStyle(
              fontSize: 19,
              color: Color.fromARGB(255, 187, 187, 187),
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          '100,000 -- 1000,000',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildTotal() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(162, 81, 65, 202),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Column(
        children: [
          Text(
            'Total',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          Text(
            '5.00',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildPayButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: MaterialButton(
        onPressed: () {
          //navigate to home page

          
Navigator.push(context,
                 MaterialPageRoute(
                        builder: (context) => const Home()));

          
          
        },
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Pay via Card',
            style: TextStyle(
                fontSize: 25,
                color: Color.fromARGB(255, 55, 39, 175),
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
