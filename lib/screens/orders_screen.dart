import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        elevation: 0,
        title: const Text("Mis Pedidos", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Tarjeta del Pedido #12345
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey[800]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Pedido #MX-8842", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(color: Colors.amber[900], borderRadius: BorderRadius.circular(5)),
                      child: const Text("En Proceso", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
                const SizedBox(height: 5),
                const Text("Fecha: Hoy", style: TextStyle(color: Colors.grey, fontSize: 12)),
                const Divider(color: Colors.grey, height: 30),
                
                // LÍNEA DE TIEMPO
                _buildTimelineTile(title: "Ordenado", subtitle: "Tu pedido ha sido confirmado", isCompleted: true, isFirst: true),
                _buildTimelineTile(title: "Preparando para envío", subtitle: "Estamos empacando tu reloj", isCompleted: true), // Simulamos que ya está en preparación
                _buildTimelineTile(title: "En camino", subtitle: "Paquetería DHL", isCompleted: false, isActive: true), // Estado actual
                _buildTimelineTile(title: "Entregado", subtitle: "Firma requerida", isCompleted: false, isLast: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget para crear cada paso de la línea de tiempo
  Widget _buildTimelineTile({
    required String title,
    required String subtitle,
    bool isCompleted = false,
    bool isActive = false,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Columna de la línea y el punto
        Column(
          children: [
            if (!isFirst) Container(width: 2, height: 30, color: isCompleted ? AppTheme.accent : Colors.grey[800]),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted || isActive ? AppTheme.accent : Colors.transparent,
                border: Border.all(color: isCompleted || isActive ? AppTheme.accent : Colors.grey, width: 2),
              ),
              child: isCompleted ? const Icon(Icons.check, size: 10, color: Colors.black) : null,
            ),
            if (!isLast) Container(width: 2, height: 30, color: (isCompleted && !isActive) ? AppTheme.accent : Colors.grey[800]),
          ],
        ),
        const SizedBox(width: 15),
        // Textos
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 2.0, bottom: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isCompleted || isActive ? Colors.white : Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}