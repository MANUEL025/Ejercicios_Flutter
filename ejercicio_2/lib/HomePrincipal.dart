import 'package:flutter/material.dart';
import 'dart:math';

class Formulario extends StatefulWidget {
  @override
  _FormularioState createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  final guessController = TextEditingController();
  late int secretNumber;
  int attempts = 0;
  String message = "";
  List<int> guesses = [];
  bool gameEnded = false; // Nueva variable para controlar el estado del juego
  String imageUrl =
      'https://opgg-static.akamaized.net/meta/images/profile_icons/profileIcon4829.jpg?image=q_auto:good,f_webp,w_auto&v=1720753648278';

  @override
  void initState() {
    super.initState();
    resetGame();
  }

  void resetGame() {
    setState(() {
      secretNumber =
          Random().nextInt(100) + 1; // Genera un número entre 1 y 100
      attempts = 0;
      message = "";
      gameEnded = false; // Reinicia el estado del juego
      guesses.clear();
    });
  }

  void checkGuess() {
    setState(() {
      if (gameEnded) return; // No hacer nada si el juego ya terminó

      int guess = int.parse(guessController.text);
      attempts++;
      guesses.add(guess);

      if (guess == secretNumber) {
        message =
            "¡Correcto! El número era $secretNumber. Adivinaste en $attempts intentos.";
        gameEnded = true;
      } else if (guess < secretNumber) {
        message = "Demasiado bajo. Intenta de nuevo.";
      } else {
        message = "Demasiado alto. Intenta de nuevo.";
      }

      if (attempts >= 5 && guess != secretNumber) {
        message =
            "Has alcanzado el límite de intentos. El número era $secretNumber.";
        "Los numeros que ingresaste fueron: $guesses ";
        gameEnded = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Pollo al Riesgo",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 4, 24, 206))),
        ),
        backgroundColor: Color.fromARGB(255, 48, 124, 211),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              child: Image(
                height: 100,
                width: 100,
                image: NetworkImage('lib/img/imagen_1.png'),
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              alignment: Alignment.center,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  children: [
                    TextSpan(text: "¡Hola!\n", style: TextStyle(height: 2.0)),
                    TextSpan(
                        text:
                            "Soy Chaplin, he pensado un número del 1 al 100 y te reto a que adivines en menos de 10 intentos\n",
                        style: TextStyle(height: 2.0)),
                    TextSpan(text: "¡Suerte!\n", style: TextStyle(height: 2.0)),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: TextField(
                controller: guessController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Inserta tu número aquí"),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: checkGuess,
                  child: Text("Adivina"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    resetGame();
                    setState(() {
                      gameEnded = false; // Reinicia el estado del juego
                    });
                  },
                  child: Text("Reiniciar"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                message,
                style: TextStyle(fontSize: 20, color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
            if (gameEnded) // Mostrar la lista de números solo al final del juego
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Números ingresados:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    ...guesses
                        .map((guess) => Text(
                              guess.toString(),
                              style:
                                  TextStyle(fontSize: 16, color: Colors.blue),
                            ))
                        .toList(),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
