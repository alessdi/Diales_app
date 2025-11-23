import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/watch_model.dart';
import '../services/cart_service.dart'; // Importamos el servicio

class DetailsScreen extends StatelessWidget {
  final Watch watch;

  const DetailsScreen({super.key, required this.watch});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      extendBodyBehindAppBar: true,
      
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. IMAGEN GRANDE
            Container(
              height: 400,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [const Color(0xFF2C2C2C), AppTheme.background],
                ),
              ),
              child: Center(
                child: Hero(
                  tag: watch.name,
                  child: Image.asset(watch.imagePath, height: 300, fit: BoxFit.contain),
                ),
              ),
            ),

            // 2. DETALLES
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(watch.name, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(watch.price, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: AppTheme.accent)),
                      const SizedBox(width: 15),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(color: Colors.red[900], borderRadius: BorderRadius.circular(5)),
                        child: const Text("Envío Gratis", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  _buildBenefitRow(Icons.local_shipping_outlined, "Envío gratis asegurado"),
                  _buildBenefitRow(Icons.verified_user_outlined, "Garantía de 1 año incluida"),
                  _buildBenefitRow(Icons.card_giftcard, "Estuche de lujo incluido"),
                  const SizedBox(height: 30),
                  const Divider(color: Colors.grey),
                  const SizedBox(height: 20),
                  const Text("Características del Reloj", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 10),
                  Text(watch.description, style: TextStyle(fontSize: 16, color: Colors.grey[400], height: 1.5)),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),

      // 5. BOTÓN DE COMPRA (Con lógica de Carrito y SnackBar)
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: AppTheme.surface,
          border: Border(top: BorderSide(color: Colors.black, width: 1)),
        ),
        child: ElevatedButton(
          onPressed: () {
            // 1. Agregamos al carrito
            CartService.add(watch);

            // 2. Mostramos el mensaje personalizado (SnackBar Estilo Dialez)
            ScaffoldMessenger.of(context).hideCurrentSnackBar(); // Ocultar anteriores
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const Icon(Icons.check_circle_outline, color: Colors.black), // Icono negro
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        "Has agregado este modelo a tu carrito",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                backgroundColor: AppTheme.accent, // Fondo Plateado/Blanco
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.all(20),
                duration: const Duration(seconds: 2),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.accent,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: const Text("AGREGAR AL CARRITO", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
      ),
    );
  }

  Widget _buildBenefitRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.accent, size: 24),
          const SizedBox(width: 15),
          Text(text, style: TextStyle(color: Colors.grey[300], fontSize: 15)),
        ],
      ),
    );
  }
}