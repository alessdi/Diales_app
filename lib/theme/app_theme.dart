import 'package:flutter/material.dart';

class AppTheme {
  // PALETA DE COLORES
  static const Color background = Color(0xFF1C1C1C); 
  static const Color surface = Color(0xFF2C2C2C);    
  static const Color primary = Color(0xFF424242);   
  static const Color accent = Color(0xFFBDBDBD);     
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Colors.grey;

  // TEMA GENERAL DE LA APP 
  static ThemeData get darkTheme {
    return ThemeData(
      scaffoldBackgroundColor: background,
      primaryColor: primary,
      fontFamily: 'Roboto', // Fuente 
      colorScheme: const ColorScheme.dark(
        primary: accent,
        surface: surface,
        onSurface: textPrimary,
      ),
      useMaterial3: true,
    );
  }

  // ESTILO DE INPUTS
  static InputDecoration inputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: textSecondary.withOpacity(0.6)),
      prefixIcon: Icon(icon, color: accent),
      filled: true,
      fillColor: surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: primary, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: accent, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    );
  }
}