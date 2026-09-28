import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MonasteriumApp());
}

class MonasteriumApp extends StatelessWidget {
  const MonasteriumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monasterium',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}