import 'package:flutter/material.dart';
import 'theme/app_theme.dart';       
import 'screens/auth_screen.dart';   // Pantalla de login

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
      
      // Tema centralizado
      theme: AppTheme.darkTheme,
      
      // Pantalla inicial
      home: const AuthScreen(),
    );
  }
}