import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/watch_model.dart';

class DetailsScreen extends StatelessWidget {
  final Watch watch;

  const DetailsScreen({super.key, required this.watch});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background, // Fondo oscuro
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white), // Flecha atrás blanca
      ),
      extendBodyBehindAppBar: true, // Para que la imagen suba hasta arriba
      
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. IMAGEN GRANDE (Con fondo degradado)
            Container(
              height: 400,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF2C2C2C), // Gris más claro arriba
                    AppTheme.background,     // Se funde con el fondo abajo
                  ],
                ),
              ),
              child: Center(
                child: Hero( // Animación de transición
                  tag: watch.name,
                  child: Image.asset(
                    watch.imagePath,
                    height: 300,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            // 2. DETALLES DEL RELOJ
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nombre
                  Text(
                    watch.name,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  
                  // Precio y Etiqueta de Ahorro (Como en tu foto)
                  Row(
                    children: [
                      Text(
                        watch.price,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.accent, // Plateado
                        ),
                      ),
                      const SizedBox(width: 15),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.red[900],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Text(
                          "Envío Gratis",
                          style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // 3. LISTA DE BENEFICIOS (Como en tu foto: Envío, Garantía, Regalos)
                  _buildBenefitRow(Icons.local_shipping_outlined, "Envío gratis asegurado"),
                  _buildBenefitRow(Icons.verified_user_outlined, "Garantía de 1 año incluida"),
                  _buildBenefitRow(Icons.card_giftcard, "Estuche de lujo incluido"),

                  const SizedBox(height: 30),
                  const Divider(color: Colors.grey),
                  const SizedBox(height: 20),

                  // 4. DESCRIPCIÓN / CARACTERÍSTICAS
                  const Text(
                    "Características del Reloj",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    watch.description, // AQUÍ SE MUESTRA EL TEXTO QUE PUSISTE EN EL MODELO
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[400],
                      height: 1.5, // Espaciado entre líneas para leer mejor
                    ),
                  ),
                  
                  const SizedBox(height: 100), // Espacio al final para el botón flotante
                ],
              ),
            ),
          ],
        ),
      ),

      // 5. BOTÓN DE COMPRA (Fijo abajo)
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: AppTheme.surface,
          border: Border(top: BorderSide(color: Colors.black, width: 1)),
        ),
        child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Añadido al carrito (Demo)")),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.accent, // Botón plateado
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: const Text(
            "AGREGAR AL CARRITO",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
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
          Text(
            text,
            style: TextStyle(
              color: Colors.grey[300],
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}