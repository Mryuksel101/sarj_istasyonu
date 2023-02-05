import 'package:flutter/material.dart';
import 'package:sarj_istasyonu/view/screens/harita.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    debugPrint("deneme");
    return const MaterialApp(

      debugShowCheckedModeBanner: false,
      home: Harita(),
    );
  }
}

