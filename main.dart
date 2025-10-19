import 'package:flutter/material.dart';

void main() {
  runApp(const NumberedImageGrid());
}

class NumberedImageGrid extends StatelessWidget {
  const NumberedImageGrid({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // removes the debug banner
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Grid of Numbers'),
          backgroundColor: Colors.blueAccent,
        ),
        body: Center(
            child: Container(
              decoration: BoxDecoration(color: Colors.blueAccent, border: Border.all(color: Colors.blueAccent, width: 3)),
              child: LayoutBuilder(
              builder: (context, constraints) {
                final gridSize = constraints.maxWidth < constraints.maxHeight ? constraints.maxWidth : constraints.maxHeight;

                return SizedBox(
                  width: gridSize - 5,
                  height: gridSize - 5, // ensures perfect square area
                  child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 4, mainAxisSpacing: 4),
                  itemCount: 16,
                  itemBuilder: (context, index) {
                    final number = index + 1;
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage('assets/images.jpg'), fit: BoxFit.cover)
                      ),
                      child: Center(
                        child: number == 16 ? null: Text('$number'),
                      ),
                    );
                  }
                  )
                );
              }
            )
              )
            )
        )
      );
    
  }
}

