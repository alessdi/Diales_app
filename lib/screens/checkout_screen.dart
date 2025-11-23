import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/dialez_widgets.dart';
import 'payment_screen.dart'; // Importamos la pantalla de pago para navegar

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  // Controladores para capturar el texto
  final _calleController = TextEditingController();
  final _numeroController = TextEditingController();
  final _cpController = TextEditingController();
  final _ciudadController = TextEditingController();
  final _referenciasController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        elevation: 0,
        title: const Text(
          "Dirección de Envío",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(), // Cierra el teclado al tocar fuera
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título de sección
              const Text(
                "¿Dónde entregamos tu reloj?",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 30),

              // --- FORMULARIO ---
              
              // Calle
              DialezTextField(
                controller: _calleController,
                hint: "Calle / Avenida",
                icon: Icons.add_road,
              ),

              // Fila para Número y CP (para que queden lado a lado)
              Row(
                children: [
                  Expanded(
                    child: DialezTextField(
                      controller: _numeroController,
                      hint: "Número Ext/Int",
                      icon: Icons.home_outlined,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: DialezTextField(
                      controller: _cpController,
                      hint: "C.P.",
                      icon: Icons.markunread_mailbox_outlined,
                    ),
                  ),
                ],
              ),

              // Ciudad
              DialezTextField(
                controller: _ciudadController,
                hint: "Ciudad / Estado",
                icon: Icons.location_city,
              ),

              // Referencias (Detalles)
              DialezTextField(
                controller: _referenciasController,
                hint: "Detalles (Ej: Portón negro, junto a Oxxo)",
                icon: Icons.info_outline,
              ),

              const SizedBox(height: 40),

              // Resumen visual simple
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppTheme.primary),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.local_shipping, color: AppTheme.accent, size: 30),
                    const SizedBox(width: 15),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Envío Estándar",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Llega en 3 a 5 días hábiles",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "GRATIS",
                      style: TextStyle(color: Colors.green[400], fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // BOTÓN CONTINUAR AL PAGO
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: AppTheme.surface,
          border: Border(top: BorderSide(color: Colors.black, width: 1)),
        ),
        child: SizedBox(
          height: 55,
          child: ElevatedButton(
            onPressed: () {
              // 1. Validar campos vacíos
              if (_calleController.text.isEmpty || 
                  _numeroController.text.isEmpty || 
                  _cpController.text.isEmpty ||
                  _ciudadController.text.isEmpty) {
                
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Por favor completa la dirección"),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              // 2. CONSTRUIR LA DIRECCIÓN COMPLETA
              String direccionCompleta = "${_calleController.text} #${_numeroController.text}, CP ${_cpController.text}, ${_ciudadController.text}. Ref: ${_referenciasController.text}";

              // 3. NAVEGAR A PAGO ENVIANDO LA DIRECCIÓN
              Navigator.push(
                context,
                MaterialPageRoute(
                  // AQUÍ ESTÁ LA CLAVE: Pasamos la variable 'direccionCompleta'
                  builder: (context) => PaymentScreen(direccionEnvio: direccionCompleta),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.accent,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            ),
            child: const Text(
              "CONTINUAR AL PAGO",
              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
            ),
          ),
        ),
      ),
    );
  }
}