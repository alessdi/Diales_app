import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';
import '../widgets/dialez_widgets.dart';
import 'home_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true; 
  bool _isPasswordVisible = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppTheme.surface, Colors.black],
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 80),
                const DialezLogoWidget(),
                const SizedBox(height: 20),
                const Text(
                  "DIALEZ",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 5, color: Colors.white),
                ),
                const Text(
                  "TIEMPO & ESTILO",
                  style: TextStyle(fontSize: 12, letterSpacing: 3, color: AppTheme.textSecondary),
                ),

                const SizedBox(height: 50),
                _buildToggle(size),
                const SizedBox(height: 40),

                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  transitionBuilder: (child, animation) => FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(animation),
                      child: child,
                    ),
                  ),
                  child: isLogin ? _buildLoginForm() : _buildRegisterForm(),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _handleAuthAction,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.accent,
                      foregroundColor: Colors.black87,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      elevation: 5,
                    ),
                    child: Text(
                      isLogin ? "INICIAR SESIÓN" : "CREAR CUENTA",
                      style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
                    ),
                  ),
                ),

                if (isLogin)
                  TextButton(
                    onPressed: () {},
                    child: Text("¿Olvidaste tu contraseña?", style: TextStyle(color: Colors.grey[500])),
                  ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // LÓGICA DE AUTENTICACIÓN PERSISTENTE 
  void _handleAuthAction() async {
    FocusScope.of(context).unfocus();

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showMessage("Por favor completa todos los campos", isError: true);
      return;
    }

    // Acceso a la memoria del telefono
    final prefs = await SharedPreferences.getInstance();

    if (isLogin) {
      // LOGIN 
      
      // Buscamos la contraseña guardada para ese email
      final storedPassword = prefs.getString(email); 

      if (storedPassword == null) {
        _showMessage("Usuario no encontrado. Regístrate primero.", isError: true);
        return;
      }

      if (storedPassword != password) {
        _showMessage("Contraseña incorrecta", isError: true);
        return;
      }

      // Login exitoso
      _showMessage("Inicio de sesión completado");
      _navigateToHome();

    } else {
      // REGISTRO 

      // Verificacion del correo existente
      if (prefs.containsKey(email)) {
        _showMessage("Este correo ya ha sido registrado", isError: true);
        return;
      }

      // Guardado del nuevo usuario
      await prefs.setString(email, password);
      
      _showMessage("Cuenta creada. Por favor inicia sesión.");
      
      // Cambia la vista a Login automáticamente para mejorar la UX
      setState(() {
        isLogin = true; 
        _passwordController.clear(); 
        _isPasswordVisible = false;
        // Email escrito para comodidad del usuario
      });
    }
  }

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_outline : Icons.check_circle_outline, 
              color: isError ? Colors.white : Colors.black
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message, 
                style: TextStyle(
                  color: isError ? Colors.white : Colors.black, 
                  fontWeight: FontWeight.bold
                )
              ),
            ),
          ],
        ),
        backgroundColor: isError ? Colors.red[800] : AppTheme.accent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(20),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    try {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } catch (e) {
      print("Error navegando: $e");
    }
  }

  Widget _buildToggle(Size size) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: AppTheme.primary,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            alignment: isLogin ? Alignment.centerLeft : Alignment.centerRight,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Container(
              width: (size.width - 60) * 0.5,
              height: 55,
              decoration: BoxDecoration(color: AppTheme.accent, borderRadius: BorderRadius.circular(30)),
            ),
          ),
          Row(
            children: [
              _toggleButton("Entrar", true),
              _toggleButton("Registrarse", false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _toggleButton(String text, bool isLoginBtn) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isLogin = isLoginBtn;
            if (_passwordController.text.isNotEmpty) _passwordController.clear();
          });
        },
        child: Container(
          color: Colors.transparent,
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: (isLogin == isLoginBtn) ? Colors.black87 : Colors.grey[400],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Column(
      key: const ValueKey('Login'),
      children: [
        DialezTextField(controller: _emailController, hint: "Correo Electrónico", icon: Icons.email_outlined),
        const SizedBox(height: 20),
        DialezTextField(
          controller: _passwordController, 
          hint: "Contraseña", 
          icon: Icons.lock_outline, 
          isPassword: true,
          isObscure: !_isPasswordVisible,
          onIconPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
        ),
      ],
    );
  }

  Widget _buildRegisterForm() {
    return Column(
      key: const ValueKey('Register'),
      children: [
        DialezTextField(controller: _nameController, hint: "Nombre Completo", icon: Icons.person_outline),
        const SizedBox(height: 20),
        DialezTextField(controller: _emailController, hint: "Correo Electrónico", icon: Icons.email_outlined),
        const SizedBox(height: 20),
        DialezTextField(
          controller: _passwordController, 
          hint: "Contraseña", 
          icon: Icons.lock_outline, 
          isPassword: true,
          isObscure: !_isPasswordVisible,
          onIconPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
        ),
      ],
    );
  }
}