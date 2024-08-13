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
  String _mensajeError = ''; // Variable para almacenar el mensaje de error
  double _saldo = 0.0; // Variable para mantener el saldo

  // Credenciales válidas
  final String _usuarioValido = 'admin';
  final String _passValido = 'admin123';

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
          image: NetworkImage('lib/img/imagen1.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                saludo(),
                usuario(),
                pass(),
                botoningreso(),
                if (_mensajeError.isNotEmpty) mensajeError(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget saludo() {
    return const Text(
      "Bienvenido",
      style: TextStyle(
        color: Colors.deepPurple,
        fontSize: 36,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
      ),
    );
  }

  Widget usuario() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: _usuarioController,
        decoration: InputDecoration(
          hintText: "Usuario",
          hintStyle: TextStyle(color: Colors.deepPurple[200]),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        ),
      ),
    );
  }

  Widget pass() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: _passController,
        obscureText: true,
        decoration: InputDecoration(
          hintText: "Contraseña",
          hintStyle: TextStyle(color: Colors.deepPurple[200]),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
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
          _validarCredenciales();
        },
        child: const Text(
          'Ingresar',
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple, // Color de fondo del botón
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 5,
        ),
      ),
    );
  }

  void _validarCredenciales() {
    final usuario = _usuarioController.text;
    final pass = _passController.text;

    if (usuario.isEmpty || pass.isEmpty) {
      setState(() {
        _mensajeError = 'Por favor, complete todos los campos.';
      });
    } else if (usuario != _usuarioValido && pass != _passValido) {
      setState(() {
        _mensajeError = 'Usuario y contraseña inválidos.';
      });
    } else if (usuario != _usuarioValido) {
      setState(() {
        _mensajeError = 'Usuario incorrecto.';
      });
    } else if (pass != _passValido) {
      setState(() {
        _mensajeError = 'Contraseña incorrecta.';
      });
    } else {
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
    }
  }

  Widget mensajeError() {
    return Text(
      _mensajeError,
      style: const TextStyle(
        color: Colors.red,
        fontSize: 16,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
      ),
    );
  }
}
