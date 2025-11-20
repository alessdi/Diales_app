import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/watch_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar minimalista
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        elevation: 0,
        title: const Text(
          "DIALEZ", 
          style: TextStyle(
            fontWeight: FontWeight.bold, 
            letterSpacing: 2,
            color: Colors.white
          )
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined, color: AppTheme.accent),
            onPressed: () {},
          ),
          const SizedBox(width: 10),
        ],
      ),
      
      // Cuerpo de la pantalla
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título de sección
            const Text(
              "Colección Exclusiva",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            // La Grid (Cuadrícula) de Relojes
            Expanded(
              child: GridView.builder(
                itemCount: myWatches.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 columnas
                  childAspectRatio: 0.75, // Proporción alto/ancho de la tarjeta
                  crossAxisSpacing: 15, // Espacio horizontal entre tarjetas
                  mainAxisSpacing: 15, // Espacio vertical entre tarjetas
                ),
                itemBuilder: (context, index) {
                  final watch = myWatches[index];
                  return _buildWatchCard(context, watch);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget individual para cada tarjeta de reloj
  Widget _buildWatchCard(BuildContext context, Watch watch) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surface, // Gris fuerte
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Imagen del Reloj
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05), // Fondo muy sutil para la imagen
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Hero(
                tag: watch.name, // Animación suave si abrimos detalles
                child: Image.asset(
                  watch.imagePath,
                  fit: BoxFit.contain, // Asegura que el reloj se vea completo
                ),
              ),
            ),
          ),

          // 2. Información del Reloj
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  watch.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      watch.price,
                      style: const TextStyle(
                        color: AppTheme.accent, // Color plateado para precio
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    // Botón de "+" pequeño
                    Container(
                      decoration: const BoxDecoration(
                        color: AppTheme.accent,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.add, size: 20, color: Colors.black),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}