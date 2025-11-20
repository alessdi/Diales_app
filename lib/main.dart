import 'package:flutter/material.dart';
import 'theme/app_theme.dart';       // Importamos el tema
import 'screens/auth_screen.dart';   // Importamos la pantalla de login

void main() {
  runApp(const DialezApp());
}

class DialezApp extends StatelessWidget {
  const DialezApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dialez Watches',
      debugShowCheckedModeBanner: false,
      
      // Usamos el tema centralizado
      theme: AppTheme.darkTheme,
      
      // Definimos la pantalla inicial
      home: const AuthScreen(),
    );
  }
}