import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Reccomend extends StatefulWidget {
  const Reccomend({super.key});

  @override
  State<Reccomend> createState() => _ReccomendState();
}

class _ReccomendState extends State<Reccomend> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Games Reccomendation'),
        ],
      ),
    );
  }
}
