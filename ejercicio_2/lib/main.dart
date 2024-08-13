import 'package:ejercicio_2/HomePrincipal.dart';
import 'package:flutter/material.dart';

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
      home: Formulario(),
      debugShowCheckedModeBanner: false,
    );
  }
}
