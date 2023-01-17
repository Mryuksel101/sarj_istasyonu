import 'package:flutter/material.dart';
import 'package:sarj_istasyonu/screens/harita.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    debugPrint("deneme");
    return const MaterialApp(
      home: Harita(),
    );
  }
}