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
      title: 'Binary Converter',
      home: const BinaryConverter(),
    );
  }
}

class BinaryConverter  extends StatefulWidget {
  const BinaryConverter ({super.key});

  @override
  State<BinaryConverter> createState() => _BinaryConverterState();
}

class _BinaryConverterState extends State<BinaryConverter> {
  final TextEditingController tempController = TextEditingController();
  String mode = 'Binary';
  String output = '';

  void wiw(String value) {
    if (value.isEmpty) {
      setState(() => output = '');
      return;
    }

    try{
      if(mode=='Binary'){
        // validate binary inout
        if(!RegExp(r'^[01]+$').hasMatch(value)){
          setState(() => output = 'Invalid binary');
          return;
        }
        int decimal = int.parse(value, radix:2);
        setState(() => output = decimal.toString());
      } else {
        int number = int.tryParse(value) ?? 0;
        setState(() => output = number.toRadixString(2));
      }
    } catch(e) {
      setState(() => output = 'Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                ClipPath(
                  clipper: TriangleClipper(),
                  child: Container(
                    width: double.infinity,
                    height: 300,
                    color: Colors.red,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      const Text(
                        "Converter",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      DropdownButton<String>(
                        value: mode,
                        items: <String>['Binary', 'Decimal'].map((String value) {
                          return DropdownMenuItem(
                              value: value, child: Text(value));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            mode = value!;
                          });
                        },
                        underline: Container(), 
                        dropdownColor: Colors.red,
                        alignment: Alignment.center,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 100,
                        child: TextField(
                          controller: tempController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.red,
                            border: InputBorder.none,
                            hintText: "2",
                          ),
                          onChanged: wiw,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Text(output),
            const SizedBox(height: 10),
            Text(mode == 'Binary' ? "Decimal" : "Binary",),
          ],
        ),
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    
    // Draw rectangular part - full width and most of height
    path.addRect(Rect.fromLTWH(0, 0, size.width, size.height - 100));

    // Draw upside-down triangle with rounded top
    path.moveTo(0, size.height - 100); // Start at bottom-left corner of rectangle
    path.lineTo(size.width, size.height - 100); // Line to bottom-right corner of rectangle
    
    // Create rounded top using quadratic Bezier curve
    path.quadraticBezierTo(
      size.width / 2 + 25, // Control point X (adjust for roundness width)
      size.height, // Control point Y (at bottom)
      size.width / 2, size.height // End point (bottom center)
    );
    
    path.quadraticBezierTo(
      size.width / 2 - 25, // Control point X (adjust for roundness width)
      size.height, // Control point Y (at bottom)
      0, size.height - 100 // Back to start point
    );
    
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}