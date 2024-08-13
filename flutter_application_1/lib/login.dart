import 'package:flutter/material.dart';
import 'calculadora.dart'; // Asegúrate de que la importación esté presente.

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  double _saldo = 0.0;

  final String usuarioValido = "admin";
  final String passValido = "1234";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: contenido(),
    );
  }

  Widget contenido() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('lib/img/imagen1.jpg'),
          fit: BoxFit.fill,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            saludo(),
            usuario(),
            pass(),
            botoningreso(),
          ],
        ),
      ),
    );
  }

  Widget saludo() {
    return const Text(
      "Bienvenido",
      style: TextStyle(
        color: Colors.white,
        fontSize: 50,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
      ),
    );
  }

  Widget usuario() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: TextField(
        controller: _usuarioController,
        decoration: InputDecoration(
          hintText: "Usuario",
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

  Widget pass() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: TextField(
        controller: _passController,
        obscureText: true,
        decoration: InputDecoration(
          hintText: "Contraseña",
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

  Widget botoningreso() {
    return SizedBox(
      width: 200,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          if (_usuarioController.text.isEmpty && _passController.text.isEmpty) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Error"),
                  content: const Text("Por favor, llene los campos"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Cierra el diálogo
                      },
                      child: const Text("OK"),
                    ),
                  ],
                );
              },
            );
          } else if (_usuarioController.text.isEmpty) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Error"),
                  content: const Text("Por favor, ingrese un usuario"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Cierra el diálogo
                      },
                      child: const Text("OK"),
                    ),
                  ],
                );
              },
            );
          } else if (_passController.text.isEmpty) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Error"),
                  content: const Text("Por favor, ingrese una contraseña"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Cierra el diálogo
                      },
                      child: const Text("OK"),
                    ),
                  ],
                );
              },
            );
          } else if (_usuarioController.text == usuarioValido &&
              _passController.text == passValido) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Calculadora(
                    usuario: _usuarioController.text, saldoActual: _saldo),
              ),
            ).then((nuevoSaldo) {
              if (nuevoSaldo != null) {
                setState(() {
                  _saldo = nuevoSaldo;
                });
              }
            });
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Error"),
                  content: const Text("Usuario o contraseña incorrecto"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Cierra el diálogo
                      },
                      child: const Text("OK"),
                    ),
                  ],
                );
              },
            );
          }
        },
        child: const Text(
          'Ingreso',
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 212, 11, 125),
        ),
      ),
    );
  }
}
