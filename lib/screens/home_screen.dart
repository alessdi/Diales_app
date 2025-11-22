import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/watch_model.dart';
import 'details_screen.dart'; // Importamos la nueva pantalla de detalles

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Colección Exclusiva",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: GridView.builder(
                itemCount: myWatches.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, 
                  childAspectRatio: 0.70, // Ajustado para que quepan los nombres
                  crossAxisSpacing: 15, 
                  mainAxisSpacing: 15, 
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
    // Usamos GestureDetector para detectar el clic en la tarjeta
    return GestureDetector(
      onTap: () {
        // Navegación a la pantalla de detalles
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(watch: watch),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.surface, 
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
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Hero(
                  tag: watch.name, // Animación Hero para transición suave
                  child: Image.asset(
                    watch.imagePath,
                    fit: BoxFit.contain, 
                  ),
                ),
              ),
            ),

            // 2. Información
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
                          color: AppTheme.accent, 
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
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
      ),
    );
  }
}