import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Welecom extends StatelessWidget {

  Future<Map<String, dynamic>> fetchData() async {
    final url = Uri.parse(
      'https://cors-anywhere.herokuapp.com/https://mobilebackendsimpleflask-imed1024-s73qk5q3.leapcell.dev/news.categories.get'
    );
    final response = await http.get(url);

    if (response.statusCode  == 200){
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome')),
      body: Container(
        margin: EdgeInsets.all(15),
        child: FutureBuilder<Map<String, dynamic>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator());
            } else if (!snapshot.hasData) {
              return Center(child: Text('No data found'));
            }  else if(snapshot.hasError) {
              return Center(child: Text('ERROR: ${snapshot.error}'));
            } else {
              final data = snapshot.data!;
              final title = data['title'];
              final time = data['time'];
              final categories = data['categories'] as List<dynamic>;
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('List of categroies'),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title),
                      // title from the api 
                      Text(time)
                    ],
                  ),
                  SizedBox(height: 2),
                  Expanded(
                    child: ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final cat = categories[index];
                        return _foo(cat['name']);
                      }
                    )
                  )
                ],
              );
            }
          }
        )
      )
    );
  }

  Widget _foo(String name){
    return Card(
      // give border shadow
      elevation: 14,
      margin: EdgeInsets.symmetric(horizontal: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(leading: Icon(Icons.category), title: Text(name)),
    );
  }
}