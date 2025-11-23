import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // <--- IMPORTANTE: Para abrir el enlace
import '../theme/app_theme.dart';
import '../models/watch_model.dart';
import 'details_screen.dart';
import 'cart_screen.dart';
import 'orders_screen.dart';
import 'auth_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // FUNCION PARA ABRIR INSTAGRAM
  Future<void> _launchInstagram() async {
    final Uri url = Uri.parse('https://www.instagram.com/dialezmods?igsh=MXJzeG9iaHRkNmo0cQ%3D%3D&utm_source=qr');
    try {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw Exception('No se pudo abrir el link $url');
      }
    } catch (e) {
      debugPrint("Error abriendo Instagram: $e");
    }
  }

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
          // BOTÓN DE INSTAGRAM
          IconButton(
            // ICONO DE CAMARA PARA INSTAGRAM
            icon: const Icon(Icons.camera_alt_outlined, color: AppTheme.accent),
            tooltip: 'Síguenos en Instagram',
            onPressed: _launchInstagram,
          ),

          // BOTÓN DEL CARRITO 
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined, color: AppTheme.accent),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
          ),
          const SizedBox(width: 10),
        ],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      
      // MENÚ LATERAL
      drawer: Drawer(
        backgroundColor: AppTheme.surface,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Cabecera del menucon informacion del usuario
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.black),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("DIALEZ", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold, letterSpacing: 3)),
                  Text("Usuario Invitado", style: TextStyle(color: AppTheme.accent)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined, color: Colors.white),
              title: const Text("Inicio", style: TextStyle(color: Colors.white)),
              onTap: () => Navigator.pop(context),
            ),
            // Opcion mis pedidos
            ListTile(
              leading: const Icon(Icons.local_shipping_outlined, color: Colors.white),
              title: const Text("Mis Pedidos", style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const OrdersScreen()));
              },
            ),
            // Link de instagram en menú lateral
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined, color: Colors.white),
              title: const Text("Instagram", style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                _launchInstagram();
              },
            ),
            const Divider(color: Colors.grey),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Cerrar Sesión", style: TextStyle(color: Colors.red)),
              onTap: () {
                 Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const AuthScreen()), (route) => false);
              },
            ),
          ],
        ),
      ),


      // CUERPO PRINCIPAL
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Colección Exclusiva", 
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300, color: Colors.white)
            ),
            const SizedBox(height: 20),

            // GRID DE PRODUCTOS
            Expanded(
              child: GridView.builder(
                itemCount: myWatches.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, 
                  childAspectRatio: 0.70, 
                  crossAxisSpacing: 15, 
                  mainAxisSpacing: 15
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

// TARJETA PARA CADA RELOJ
  Widget _buildWatchCard(BuildContext context, Watch watch) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(watch: watch))),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.surface, 
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: const BorderRadius.vertical(top: Radius.circular(20))),
                child: Hero(tag: watch.name, child: Image.asset(watch.imagePath, fit: BoxFit.contain)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(watch.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(watch.price, style: const TextStyle(color: AppTheme.accent, fontWeight: FontWeight.w500, fontSize: 14)),
                      Container(decoration: const BoxDecoration(color: AppTheme.accent, shape: BoxShape.circle), child: const Icon(Icons.add, size: 20, color: Colors.black))
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