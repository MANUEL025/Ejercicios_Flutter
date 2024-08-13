import 'package:flutter/material.dart';

class Calculadora extends StatefulWidget {
  final String usuario;
  final double saldoActual;

  const Calculadora({Key? key, required this.usuario, this.saldoActual = 0.0})
      : super(key: key);

  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  final TextEditingController _recargaController = TextEditingController();
  final TextEditingController _minuto1Controller =
      TextEditingController(text: "0");
  final TextEditingController _minuto2Controller =
      TextEditingController(text: "0");
  final TextEditingController _minuto11Controller =
      TextEditingController(text: "0");

  double _saldo = 0.0;
  int _minutos = 0;

  @override
  void initState() {
    super.initState();
    _saldo = widget.saldoActual;
  }

  void _recargar() {
    final double recarga = double.tryParse(_recargaController.text) ?? 0.0;
    final double minuto1 = double.tryParse(_minuto1Controller.text) ?? 90.0;
    final double minuto2 = double.tryParse(_minuto2Controller.text) ?? 80.0;
    final double minuto11 = double.tryParse(_minuto11Controller.text) ?? 50.0;

    setState(() {
      _saldo += recarga;
      _minutos = 0;

      if (_saldo < minuto1) {
        _minutos = 0;
      } else {
        _saldo -= minuto1;
        _minutos = 1;

        for (int i = 2; i <= 10 && _saldo >= minuto2; i++) {
          _saldo -= minuto2;
          _minutos++;
        }

        while (_saldo >= minuto11) {
          _saldo -= minuto11;
          _minutos++;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 212, 11, 125),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context, _saldo);
          },
        ),
      ),
      body: contenidoCalculadora(),
    );
  }

  Widget contenidoCalculadora() {
    return Container(
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
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Saldo Actual: \$$_saldo",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 20),
            saldo(),
            SizedBox(height: 20),
            minuto1(),
            SizedBox(height: 20),
            minuto2(),
            SizedBox(height: 20),
            minuto11(),
            SizedBox(height: 20),
            botonRecargar(),
            if (_minutos > 0)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  "Minutos: $_minutos\nSaldo Restante: \$$_saldo",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            if (_saldo < double.parse(_minuto1Controller.text) && _minutos == 0)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: const Text(
                  "Saldo insuficiente",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget saldo() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: _recargaController,
        decoration: InputDecoration(
          labelText: "Valor a recargar",
          labelStyle: TextStyle(color: Colors.deepPurple[300]),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget minuto1() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: _minuto1Controller,
        decoration: InputDecoration(
          hintText: "Costo del Minuto 1",
          labelStyle: TextStyle(color: Colors.deepPurple[300]),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget minuto2() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: _minuto2Controller,
        decoration: InputDecoration(
          labelText: "Costo de Minuto 2 al 10",
          labelStyle: TextStyle(color: Colors.deepPurple[300]),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget minuto11() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: _minuto11Controller,
        decoration: InputDecoration(
          labelText: "Costo de Minuto 11 en adelante",
          labelStyle: TextStyle(color: Colors.deepPurple[300]),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget botonRecargar() {
    return SizedBox(
      width: 200,
      height: 50,
      child: ElevatedButton(
        onPressed: _recargar,
        child: const Text("Recargar"),
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
}
