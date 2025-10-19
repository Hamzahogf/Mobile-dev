import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'min max rand',
      home: const RandomNumberScreen (),
    );
  }
}

class RandomNumberScreen extends StatefulWidget {
  const RandomNumberScreen({super.key});

  @override
  State<RandomNumberScreen> createState() => _RandomNumberScreenState();
}

class _RandomNumberScreenState extends State<RandomNumberScreen> {
  int randomNumber = 0;
  int min = 0;
  int max = 100;

  final TextEditingController minController = TextEditingController();
  final TextEditingController maxController = TextEditingController();

  void generateRandomNumber() {
    int currentMin = int.tryParse(minController.text) ?? 0;
    int currentMax = int.tryParse(maxController.text) ?? 100;
    if (currentMin > currentMax) {
      // swap if min > max
      int temp = currentMin;
      currentMin = currentMax;
      currentMax = temp;
    }

    setState(() {
      min = currentMin;
      max = currentMax;
      randomNumber = Random().nextInt(max - min + 1) + min;
    });
  }

  Widget buildNumberButton(String label) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: ElevatedButton(
          onPressed: () {
            final controller = minFocus ? minController : maxController;

            if (label == '<') {
              // Delete last character
              if (controller.text.isNotEmpty) {
                controller.text =
                    controller.text.substring(0, controller.text.length - 1);
              }
            } else if (label == '>') {
              // You can define some action for '>' if needed
            } else {
              // Append number
              controller.text += label;
            }
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20),
            backgroundColor: (label == '<' || label == '>') 
              ? Colors.blueGrey 
              : Colors.grey[300],

            shadowColor: (label == '<' || label == '>') 
              ? Colors.transparent 
              : null,
          ),
          child: label == '<' 
            ? const Icon(Icons.backspace, size: 24) // use icon for '<'
            : Text(
                label,
                style: const TextStyle(fontSize: 24),
              ),
        ),
      ),
    );
  }


  bool minFocus = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SafeArea(
        child:  Column(
            children: [
              // Random number display
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  '$randomNumber',
                  style: const TextStyle(
                      fontSize: 48, fontWeight: FontWeight.bold),
                ),
              ),

              // Min / Max inputs
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text("Min"),
                          ),
                          TextField(
                            controller: minController,
                            keyboardType: TextInputType.none, 
                            textAlign: TextAlign.center,// disable system keyboard
                            onTap: () => setState(() => minFocus = true),
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.amber,
                              border: InputBorder.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text("Max"),
                          ),
                          TextField(
                            controller: maxController,
                            keyboardType: TextInputType.none,
                            textAlign: TextAlign.center,
                            onTap: () => setState(() => minFocus = false),
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.amber,
                              border: InputBorder.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              Expanded(
                child: Container(
                  color: Colors.blueGrey, // use color instead of backgroundColor
                  padding: const EdgeInsets.only(left: 8, top: 8, right: 8),
                  child: Column(
                    children: [
                      Row(children: ['7', '8', '9'].map(buildNumberButton).toList()),
                      Row(children: ['4', '5', '6'].map(buildNumberButton).toList()),
                      Row(children: ['1', '2', '3'].map(buildNumberButton).toList()),
                      Row(children: ['>', '0', '<'].map(buildNumberButton).toList()),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: generateRandomNumber,
                        child: const Text('Generate'),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
      ),
    );
  }
}