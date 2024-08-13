import 'package:flutter/material.dart';
import 'package:flutter_application_2/pag1.dart';


void main() {
  runApp(const Inicio());
}

class Inicio extends StatelessWidget {
  const Inicio({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Filas columnas',
      debugShowCheckedModeBanner: false,
      home: Pag1 (),
      );
  }
}
