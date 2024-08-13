import 'package:flutter/material.dart';
import 'HomePrincipal.dart';

class Principal extends StatelessWidget {
  const Principal({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Ejemplo 1",
      debugShowCheckedModeBanner: false,
      home: HomePrincipal(),
    );
  }
}
