import 'package:flutter/material.dart';

void main() {
  runApp(const XOImageGrid());
}

class XOImageGrid extends StatelessWidget {
  const XOImageGrid({super.key});
  @override
  Widget build(BuildContext context) {
    final List<IconData?> gridContent = [Icons.close, Icons.close, Icons.close, Icons.circle_outlined, Icons.circle_outlined, Icons.close, null, Icons.circle_outlined, null];
    return MaterialApp(
      debugShowCheckedModeBanner: false, // removes the debug banner
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tic Tac Toe'),
          backgroundColor: Colors.blueAccent,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Game Over, Congrats to Player X', style: TextStyle(color: Colors.lightGreen, fontSize: 22)),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Center(
              child: Container(
                decoration: BoxDecoration(color: Colors.grey, border: Border.all(color: Colors.grey, width: 4)),
                child: LayoutBuilder(
                builder: (context, constraints) {
                  final gridSize = constraints.maxWidth < constraints.maxHeight ? constraints.maxWidth : constraints.maxHeight;
              
                  return SizedBox(
                    width: gridSize - 8,
                    height: gridSize - 8, // ensures perfect square area
                    child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 3, mainAxisSpacing: 4),
                    itemCount: gridContent.length,
                    itemBuilder: (context, index) {
                      final icon = gridContent[index];
                      return Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage('assets/images.jpg'), fit: BoxFit.cover)
                        ),
                        child: Center(
                          child: icon == null ? null : Icon(icon, size: 64, color: icon == Icons.close? Colors.red : Colors.yellow),
                        ),
                      );
                    }
                    )
                  );
                  }
                )
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.height * 0.04,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'Play Again',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ]
        )
      )
      );
  }
}

