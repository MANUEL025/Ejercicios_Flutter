import 'package:flutter/material.dart';

class HomePrincipal extends StatefulWidget {
  const HomePrincipal({super.key});

  @override
  State<HomePrincipal> createState() => _HomePrincipalState();
}

class _HomePrincipalState extends State<HomePrincipal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Pruebas",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 39, 199, 92))),
        ),
        backgroundColor: Color.fromARGB(255, 80, 82, 196),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Color.fromARGB(255, 48, 124, 211),
          child: ListView(
            children: [
              Image(
                  image: NetworkImage(
                      'https://opgg-static.akamaized.net/meta/images/profile_icons/profileIcon4829.jpg?image=q_auto:good,f_webp,w_auto&v=1720753648278')),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(child: Text('texto 1')),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(child: Text('texto 2')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 252, 251, 251),
                  radius: 100,
                  child: const CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://cdn.pixabay.com/photo/2016/05/31/11/43/backwards-1426683_1280.png'),
                    radius: 90,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
