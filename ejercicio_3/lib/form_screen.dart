import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _rechargeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String _min1 = '';
  String _min2To10 = '';
  String _min11AndAbove = '';

  void _calculate() {
    if (_formKey.currentState!.validate()) {
      final double recharge = double.tryParse(_rechargeController.text) ?? 0;
      if (recharge <= 0) {
        return;
      }

      setState(() {
        // Valor minuto 1 (90 pesos por minuto)
        int min1Count = (recharge ~/ 90).toInt();
        _min1 = min1Count.toString();

        // Valor minutos del 2 al 10 (80 pesos por minuto)
        final double remainingAfterMin1 = recharge - (min1Count * 90);
        int min2To10Count = (remainingAfterMin1 ~/ 80).toInt();
        _min2To10 = min2To10Count.toString();

        // Valor minuto mayor a 11 (50 pesos por minuto)
        final double remainingAfterMin2To10 =
            remainingAfterMin1 - (min2To10Count * 80);
        _min11AndAbove = (remainingAfterMin2To10 / 50).toStringAsFixed(2);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _rechargeController,
                decoration: InputDecoration(
                  labelText: 'Ingrese el monto de recarga',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un monto';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Ingrese un número válido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _calculate,
                child: Text('Calcular'),
              ),
              SizedBox(height: 20),
              Text('Minutos para valor de minuto 1: $_min1 minutos'),
              Text(
                  'Minutos para valor de minutos del 2 al 10: $_min2To10 minutos'),
              Text(
                  'Minutos para valor mayor a 11 minutos: $_min11AndAbove minutos'),
            ],
          ),
        ),
      ),
    );
  }
}
