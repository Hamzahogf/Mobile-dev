import 'package:flutter/material.dart';
import 'package:lab6_c1/WelecomScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: StringReverser());
  }
}

class StringReverser extends StatefulWidget {
  @override
  _StringReverserState createState() => _StringReverserState();
}

class _StringReverserState extends State<StringReverser> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: _isLoading 
      ? Center(child: CircularProgressIndicator())
      : Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Please log in to continue'),
            SizedBox(height: 5),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'UserName'),
              validator: (value) {
                if(value==null || value.trim().isEmpty){
                  return 'Pleas enter a username';
                } else if (value.trim().length < 4){
                  return 'Username must be more than 3 letters';
                }
                return null;
              }
            ),
            ElevatedButton(
              onPressed: _login, 
              child: Text('Login')
            )
          ],
        ),
      ),
    );
  }

  void _login() async {
    if(!_formKey.currentState!.validate()) return;
    
    setState(() {
        _isLoading = true;
      });

      await Future.delayed(Duration(seconds: 5));

      setState(() {
        _isLoading = false;
      });
    if(_usernameController.text.trim().toLowerCase() == 'ensia'){
      Navigator.push(context, MaterialPageRoute(builder: (context) => Welecom()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Incorrect username ❌'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}