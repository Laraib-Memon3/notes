import 'package:flutter/material.dart';
void main() => runApp(Home_Screen());
class Home_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Home Screen')),
        body: Center(child: Text('Welcome to the Home Screen!')),
      ),
    );
  }
}

 