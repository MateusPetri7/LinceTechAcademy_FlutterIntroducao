import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String botaoCorreto;
  int tentativas = 2;
  bool jogoEncerrado = false;
  Color backgroundColor = Colors.white;

  void iniciarJogo() {
    setState(() {
      final random = Random();
      final int indiceBotaoCorreto = random.nextInt(3);
      if (indiceBotaoCorreto == 0) {
        botaoCorreto = 'A';
      } else if (indiceBotaoCorreto == 1) {
        botaoCorreto = 'B';
      } else {
        botaoCorreto = 'C';
      }

      tentativas = 2;
      jogoEncerrado = false;
      backgroundColor = Colors.white;
    });
  }

  void verificarBotao(String botao) {
    setState(() {
      if (botao == botaoCorreto) {
        backgroundColor = Colors.green;
        jogoEncerrado = true;
      } else {
        tentativas--;
        if (tentativas == 0) {
          backgroundColor = Colors.red;
          jogoEncerrado = true;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogo de Botões',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Jogo de Botões'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (!jogoEncerrado) {
                    verificarBotao('A');
                  }
                },
                child: Text('A'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (!jogoEncerrado) {
                    verificarBotao('B');
                  }
                },
                child: Text('B'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (!jogoEncerrado) {
                    verificarBotao('C');
                  }
                },
                child: Text('C'),
              ),
              SizedBox(height: 20),
              Visibility(
                visible: jogoEncerrado,
                child: Text(
                  tentativas == 0 ? 'Você perdeu!' : 'Você acertou!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: iniciarJogo,
          child: Icon(Icons.refresh),
        ),
        backgroundColor: backgroundColor,
      ),
    );
  }
}
