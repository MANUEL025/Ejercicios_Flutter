import 'package:flutter/material.dart';
import 'login.dart';

void main() {
  runApp(const Inicio());
}

class Inicio extends StatelessWidget {
  const Inicio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ejercicio Widget",
      debugShowCheckedModeBanner: false,
      home: const Login(),
    );
  }
}
