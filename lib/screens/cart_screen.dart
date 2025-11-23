import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/watch_model.dart';
import '../services/cart_service.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartItems = CartService.items;

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        elevation: 0,
        title: const Text("Mi Carrito", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // LISTA DE PRODUCTOS
          Expanded(
            child: cartItems.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    itemCount: cartItems.length,
                    padding: const EdgeInsets.all(20),
                    itemBuilder: (context, index) {
                      final watch = cartItems[index];
                      return _buildCartItem(watch);
                    },
                  ),
          ),

          // RESUMEN DE PAGO (Solo si hay items)
          if (cartItems.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 20, offset: Offset(0, -5))],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total Estimado:", style: TextStyle(color: Colors.grey, fontSize: 16)),
                      Text(
                        CartService.getTotal(),
                        style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        // Aquí iría la pasarela de pago
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Procesando pago...")),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.accent,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      child: const Text("PAGAR AHORA", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey[800]),
          const SizedBox(height: 20),
          const Text("Tu carrito está vacío", style: TextStyle(color: Colors.white, fontSize: 20)),
          const SizedBox(height: 10),
          const Text("Explora nuestra colección exclusiva", style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildCartItem(Watch watch) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C), // Un gris un poco más claro que el fondo
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          // Imagen
          Container(
            width: 80,
            height: 80,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(watch.imagePath, fit: BoxFit.contain),
          ),
          const SizedBox(width: 15),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(watch.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 5),
                Text(watch.price, style: const TextStyle(color: AppTheme.accent, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          // Botón Eliminar
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.grey),
            onPressed: () {
              setState(() {
                CartService.remove(watch);
              });
            },
          ),
        ],
      ),
    );
  }
}