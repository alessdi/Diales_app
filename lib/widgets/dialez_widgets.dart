import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

// 1. INPUT PERSONALIZADO (Actualizado para soportar "Ver Contraseña")
class DialezTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool isPassword;       // Indica si es un campo de contraseña
  final bool isObscure;        // Indica si el texto está oculto actualmente
  final VoidCallback? onIconPressed; // Acción al tocar el icono del ojo

  const DialezTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
    this.isPassword = false,
    this.isObscure = false, // Por defecto no oculta (a menos que lo controlemos desde fuera)
    this.onIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: TextField(
        controller: controller,
        obscureText: isObscure, // Aquí se aplica la magia de ocultar/mostrar
        style: const TextStyle(color: AppTheme.textPrimary),
        decoration: AppTheme.inputDecoration(hint: hint, icon: icon).copyWith(
          // Agregamos el icono al final solo si es contraseña
          suffixIcon: isPassword 
            ? IconButton(
                icon: Icon(
                  // Cambia el icono según si se ve o no
                  isObscure ? Icons.visibility_off : Icons.visibility,
                  color: AppTheme.textSecondary,
                ),
                onPressed: onIconPressed,
              )
            : null,
        ),
      ),
    );
  }
}

// 2. LOGO DE LA APP
class DialezLogoWidget extends StatelessWidget {
  const DialezLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: const Color(0xFF333333),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 15,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Text(
              "D",
              style: TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.w900,
                color: Color(0xFFE0E0E0),
                height: 1,
              ),
            ),
            Positioned(
              right: 18,
              bottom: 22,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF333333), width: 3),
                ),
                child: const Icon(Icons.watch_later_outlined, color: Color(0xFF333333), size: 30),
              ),
            )
          ],
        ),
      ),
    );
  }
}