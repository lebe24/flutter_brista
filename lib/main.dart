import 'package:flutter/material.dart';
import 'package:flutter_brista/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor:const Color(0xFBE3DEDE)
      ),
      home: const HomePage(),
    );
  }
}