import 'package:flutter/material.dart';
import 'dart:math';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: darkBlue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: MyWidget(),
        ),
      ),
    );
  }
}

enum StatusJogo { EmAndamento, Ganhou, Perdeu }

class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final random = Random();

  var botaoCorreto = 0;
  var clicks = 0;
  var status = StatusJogo.EmAndamento;
  var vitorias = 0;
  var derrotas = 0;

  @override
  void initState() {
    super.initState();
    botaoCorreto = random.nextInt(3);
  }

  void tentativa(int opcao) {
    setState(() {
      switch (status) {
        case StatusJogo.EmAndamento:
          if (opcao == botaoCorreto) {
            status = StatusJogo.Ganhou;
            vitorias++;
          } else {
            clicks++;
            if (clicks >= 2) {
              status = StatusJogo.Perdeu;
              derrotas++;
            }
          }
          break;
        case StatusJogo.Ganhou:
        case StatusJogo.Perdeu:
          botaoCorreto = random.nextInt(3);
          clicks = 0;
          status = StatusJogo.EmAndamento;
          break;
      }
    });
  }

  Widget buildEmAndamento() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          child: const Text('A'),
          onPressed: () {
            tentativa(0);
          },
        ),
        ElevatedButton(
          child: const Text('B'),
          onPressed: () {
            tentativa(1);
          },
        ),
        ElevatedButton(
          child: const Text('C'),
          onPressed: () {
            tentativa(2);
          },
        ),
        const SizedBox(height: 20),
        Text('Vitórias: $vitorias | Derrotas: $derrotas'),
      ],
    );
  }

  Widget buildGanhou() {
    return Container(
      color: Colors.green,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Você ganhou'),
          ElevatedButton(
            onPressed: () {
              tentativa(-1); // Reiniciar o jogo
            },
            child: const Text('Reiniciar'),
          ),
        ],
      ),
    );
  }

  Widget buildPerdeu() {
    return Container(
      color: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Você perdeu'),
          ElevatedButton(
            onPressed: () {
              tentativa(-1); // Reiniciar o jogo
            },
            child: const Text('Reiniciar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case StatusJogo.EmAndamento:
        return buildEmAndamento();
      case StatusJogo.Ganhou:
        return buildGanhou();
      case StatusJogo.Perdeu:
        return buildPerdeu();
      default:
        return buildEmAndamento();
    }
  }
}
