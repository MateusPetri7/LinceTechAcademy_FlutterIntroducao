import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color textColor = Colors.black;

  void alterarCorTexto() {
    setState(() {
      textColor =
          Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cor Aleatória',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cor Aleatória'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: alterarCorTexto,
                child: Text(
                  'Toque para mudar a cor do texto',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: textColor,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: alterarCorTexto,
                child: Text('Sortear cor'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
