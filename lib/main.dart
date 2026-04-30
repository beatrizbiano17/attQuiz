import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Quiz',
    initialRoute: '/',
    routes: {
      '/': (context) => TelaInicial(),
      
    },
  ));
}
 class TelaInicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz"),
      ),
      body: Center(
      
        child: ElevatedButton(
          child: Text("Começar"),
          onPressed: () {
            Navigator.pushNamed(context, '/temas');
          },
        ),
      ),
    );
  }
}