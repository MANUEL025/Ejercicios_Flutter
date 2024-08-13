import 'package:flutter/material.dart';
import 'Principal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minijuego',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Principal(),
      debugShowCheckedModeBanner: false, 
    );
  }
}
