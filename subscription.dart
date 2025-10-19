import 'package:flutter/material.dart';

class Subscritpion extends StatefulWidget {
  const Subscritpion({super.key});

  @override
  State<Subscritpion> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscritpion> {
  int selectedIndex = -1;
  final List<Map<String,dynamic>> offers = [
    {'header':'Free','description':'7 days','is_Selected': true},
    {'header':'8', 'description':'30 days', 'is_Selected': false}, 
    {'header':'14', 'description':'3 months', 'is_Selected':false}, 
    {'header':'199', 'description':'one time', 'is_Selected': false}
  ];
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscription'),
        centerTitle: true,
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back))
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const Text(
            'Choose \nYour Plan',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
/*
          // ✅ Expanded should be directly inside main Column
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: MediaQuery.of(context).size.width * 0.03,
              mainAxisSpacing: MediaQuery.of(context).size.height * 0.03,
              shrinkWrap: true, // makes the grid take only the needed space
              
              physics: const NeverScrollableScrollPhysics(), // disables scrolling
              children: offers.map((offer) {
                return getPriceBoxWidget(
                  offer['header'],
                  offer['description'],
                  offer['is_Selected'],
                );
              }).toList(),
            ),
          ),
*/

          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: MediaQuery.of(context).size.width * 0.03,
              mainAxisSpacing: MediaQuery.of(context).size.height * 0.03,
              shrinkWrap: true, // makes the grid take only the needed space
              childAspectRatio: 1.2, // controls width/height ratio of cards
              physics: const NeverScrollableScrollPhysics(), // disables scrolling
              children: List.generate(offers.length, (index) {
                final offer = offers[index];
                final isSelected = selectedIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index; // ✅ only one stays selected
                    });
                  },
                  child: getPriceBoxWidget(
                    offer['header'],
                    offer['description'],
                    isSelected,
                  ),
                );
              }),
            ),
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.03),

          // ✅ The feature rows and button come after the Expanded
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Colors.green, shape: BoxShape.circle),
                padding:
                    EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
                child: const Icon(Icons.check, color: Colors.white, size: 16),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
              const Text('Unlock over 10 courses'),
            ],
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.02),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Colors.green, shape: BoxShape.circle),
                padding:
                    EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
                child: const Icon(Icons.check, color: Colors.white, size: 16),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
              const Text('Unlock over 40 education videos'),
            ],
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.02),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Colors.green, shape: BoxShape.circle),
                padding:
                    EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
                child: const Icon(Icons.check, color: Colors.white, size: 16),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
              const Text('View more than 50 tips'),
            ],
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.03),

          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.06,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.width * 0.05,
                  ),
                ),
              ),
              child: const Text(
                'Subscribe now',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),

    );
  }

  Widget getPriceBoxWidget(String topText, String bottomText, bool isSelected){
    return Card(
        color: isSelected? Colors.blue[100] : Colors.grey.shade300,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              Text('\$${topText}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: isSelected? Colors.blue : Colors.black)),
              Text('${bottomText}', style: TextStyle(fontSize: 16, color: isSelected? Colors.blue : Colors.black))
            ],
          ),
        ),
    );
  }
}