import 'package:flutter/material.dart';

class Cards extends StatefulWidget {
  const Cards({super.key});

  @override
  State<Cards> createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  final List<Map<String,dynamic>> foo = [
    {'image': 'assets/cow.jpg', 'header': 'Best cow in the world', 'period': '5 min ago', 'description': 'Lotrom lapsum is simple durablity text of the printing and tupesetting industry simply dummy text'},
    {'image': 'assets/cat.jpg', 'header': 'Best cat in the world', 'period': '15 min ago', 'description': 'Lotrom lapsum is simple durablity text of the printing and tupesetting industry simply dummy text'},
    {'image': 'assets/horse.jpg', 'header': 'Best hourse in the world', 'period': '13 min ago', 'description': 'Lotrom lapsum is simple durablity text of the printing and tupesetting industry simply dummy text'}
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // removes the debug banner
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Card'),
          backgroundColor: Colors.white,
          leading: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back))
        ),
        body: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: foo.length,
          itemBuilder: (context, index) {
            final item = foo[index];
            return Padding(
              padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.01),
              child: build_card(item['image'], item['header'], item['period'], item['description']),
            );
          },
        )
      )
    );
  }

  Widget build_card(image, header, period, description){
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.025)),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: const Color.fromARGB(255, 9, 62, 10), 
              width: 6
            )
          )
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.04, vertical: MediaQuery.of(context).size.height * 0.02),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Image.asset(
                        image,
                        width: MediaQuery.of(context).size.width * 0.24,
                        height: MediaQuery.of(context).size.height * 0.1,
                        fit: BoxFit.cover,
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start, 
                    children: [
                      Text(header, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      Text(period, style: TextStyle(color: Colors.grey))
                    ],
                  )
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Text(description, style: TextStyle(color: Colors.grey))
            ],
          ),
        ),
      ),
    );
  }
}
