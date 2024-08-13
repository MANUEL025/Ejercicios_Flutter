import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Pag1 extends StatefulWidget {
  const Pag1({super.key});

  @override
  State<Pag1> createState() => _Pag1State();
}

class _Pag1State extends State<Pag1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Pagina 1"),
        ),
      ),
      body: Contenido(),
    );
  }
}

Widget Contenido() {
  return Column(children: <Widget>[
    Container(
      color: const Color.fromARGB(255, 246, 235, 137),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Distribuir Filas y Columnas"),
        ],
      ),
    ),
    Container(
      color: Colors.red,
      child: const Text("color Rojo"),
    ),
    Container(
      color: Colors.yellow,
      child: Text("Amarillo"),
    ),
    Container(
      color: Colors.blue,
      child: Text("Azul"),
    ),
    Container(
      color: Colors.green,
      child: Text("Verde"),
    ),
    Container(
      color: const Color.fromARGB(255, 246, 235, 137),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Distribuir Filas y Columnas"),
        ],
      ),
    ),
  ]);
}