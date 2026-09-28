import 'package:flutter/material.dart';

class AppTheme {
  // Cores inspiradas em manuscritos antigos
  static const Color pergaminhoFundo = Color(0xFFF7F3E9);
  static const Color pergaminhoCard = Color(0xFFEFE6D5);
  static const Color textoEscuro = Color(0xFF2C221E);
  static const Color douradoSacro = Color(0xFF8C6D23);
  static const Color vermelhoSanguineo = Color(0xFF7A1C1C);

  static ThemeData get sepiaTheme {
    return ThemeData(
      scaffoldBackgroundColor: pergaminhoFundo,
      primaryColor: douradoSacro,
      colorScheme: const ColorScheme.light(
        primary: douradoSacro,
        secondary: vermelhoSanguineo,
        surface: pergaminhoCard,
      ),
      fontFamily: 'Serif',
      appBarTheme: const AppBarTheme(
        backgroundColor: pergaminhoFundo,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: textoEscuro),
        titleTextStyle: TextStyle(
          color: textoEscuro,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'Serif',
        ),
      ),
      cardTheme: const CardThemeData(
        color: pergaminhoCard,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: textoEscuro, fontSize: 18, height: 1.5),
        bodyMedium: TextStyle(color: textoEscuro, fontSize: 15),
        titleLarge: TextStyle(color: textoEscuro, fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }
}