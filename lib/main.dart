import 'package:flutter/material.dart';
import 'home.dart';

void main() => runApp(MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.greenAccent,
        cardColor: Colors.blueAccent,
        useMaterial3: true,
      ),
      home: const Home(),
    ));
