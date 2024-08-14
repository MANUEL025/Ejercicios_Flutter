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
  final TextEditingController _minuto1Controller = TextEditingController();
  final TextEditingController _minuto2Controller = TextEditingController();
  final TextEditingController _minuto11Controller = TextEditingController();

  double _saldo = 0.0;
  int _minutos = 0;
  bool _saldoInsuficiente = false;

  @override
  void initState() {
    super.initState();
    _saldo = widget.saldoActual;
  }

  void _recargar() {
    final double recarga = double.tryParse(_recargaController.text) ?? 0.0;
    final double? minuto1 = double.tryParse(_minuto1Controller.text);
    final double? minuto2 = double.tryParse(_minuto2Controller.text);
    final double? minuto11 = double.tryParse(_minuto11Controller.text);

    // Validar que los campos no sean nulos
    if (minuto1 == null || minuto2 == null || minuto11 == null) {
      _mostrarAlerta("Por favor, complete todos los campos.");
      return;
    }

    // Validar que minuto1 sea mayor que minuto2
    if (minuto1 <= minuto2) {
      _mostrarAlerta("El Valor del Minuto 1 debe ser mayor que el Valor de Minuto 2.");
      return;
    }

    // Validar que minuto2 sea mayor que minuto11
    if (minuto2 <= minuto11) {
      _mostrarAlerta("El Valor de Minuto 2 debe ser mayor que el Valor de Minuto 11.");
      return;
    }

    // Validar que minuto2 y minuto11 no sean mayores que minuto1
    if (minuto2 > minuto1 || minuto11 > minuto1) {
      _mostrarAlerta("Los valores de los minutos no pueden ser mayores que el Valor del Minuto 1.");
      return;
    }

    _saldo += recarga;
    _minutos = 0;
    _saldoInsuficiente = false;

    if (_saldo < minuto1) {
      // Si el saldo después de la recarga es menor que el Valor del minuto 1
      setState(() {
        _saldoInsuficiente = true;
      });
    } else {
      // Si todos los Valors de minutos están definidos, realizamos la operación.
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

      setState(() {});
    }
  }

  void _mostrarAlerta(String mensaje) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Advertencia'),
          content: Text(mensaje),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Saldo Actual: \$$_saldo",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          saldo(),
          const SizedBox(height: 20),
          // Usamos Row para organizar los campos de minutos
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: minuto1()),
              const SizedBox(width: 10), // Espaciado entre los campos
              Expanded(child: minuto2()),
            ],
          ),
          const SizedBox(height: 20),
          minuto11(),
          const SizedBox(height: 20),
          botonRecargar(),
          if (_minutos > 0)
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                "Minutos: $_minutos\nSaldo Restante: \$$_saldo",
                style: const TextStyle(fontSize: 20, color: Colors.green),
                textAlign: TextAlign.center,
              ),
            ),
          if (_saldoInsuficiente)
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "Saldo insuficiente",
                style: TextStyle(fontSize: 20, color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }

  Widget saldo() {
    return TextField(
      controller: _recargaController,
      decoration: const InputDecoration(
        labelText: "Valor a recargar",
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
    );
  }

  Widget minuto1() {
    return TextField(
      controller: _minuto1Controller,
      decoration: const InputDecoration(
        labelText: "Valor del Minuto 1",
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
    );
  }

  Widget minuto2() {
    return TextField(
      controller: _minuto2Controller,
      decoration: const InputDecoration(
        labelText: "Valor de Minuto 2 al 10",
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
    );
  }

  Widget minuto11() {
    return TextField(
      controller: _minuto11Controller,
      decoration: const InputDecoration(
        labelText: "Valor de Minuto 11 en adelante",
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
    );
  }

  Widget botonRecargar() {
    return ElevatedButton(
      onPressed: _recargar,
      child: const Text(
        'Recargar',
        style: TextStyle(color: Color.fromARGB(255, 243, 244, 244)),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 212, 11, 125),
      ),
    );
  }
}
