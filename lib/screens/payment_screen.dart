import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../theme/app_theme.dart';
import '../widgets/dialez_widgets.dart';
import '../services/cart_service.dart';
import 'home_screen.dart';

class PaymentScreen extends StatefulWidget {
  final String direccionEnvio;

  const PaymentScreen({super.key, this.direccionEnvio = "Dirección no especificada"});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _cardNumberController = TextEditingController();
  final _cardHolderController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();

  bool _isSending = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        elevation: 0,
        title: const Text("Método de Pago", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _isSending 
        ? const Center(child: CircularProgressIndicator(color: AppTheme.accent))
        : SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Resumen de Dirección
                Container(
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.only(bottom: 30),
                  decoration: BoxDecoration(
                    color: AppTheme.surface,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey[800]!),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on, color: AppTheme.accent),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Enviando a:", style: TextStyle(color: Colors.grey, fontSize: 12)),
                            Text(widget.direccionEnvio, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const Text("Datos de Tarjeta", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                DialezTextField(controller: _cardHolderController, hint: "Nombre del Titular", icon: Icons.person),
                DialezTextField(controller: _cardNumberController, hint: "Número de Tarjeta", icon: Icons.credit_card),
                Row(
                  children: [
                    Expanded(child: DialezTextField(controller: _expiryController, hint: "MM/AA", icon: Icons.calendar_today)),
                    const SizedBox(width: 15),
                    Expanded(child: DialezTextField(controller: _cvvController, hint: "CVV", icon: Icons.lock, isPassword: true, isObscure: true)),
                  ],
                ),
                
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total a Pagar:", style: TextStyle(color: Colors.grey, fontSize: 16)),
                    Text(CartService.getTotal(), style: const TextStyle(color: AppTheme.accent, fontSize: 24, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(color: AppTheme.surface, border: Border(top: BorderSide(color: Colors.black))),
        child: SizedBox(
          height: 55,
          child: ElevatedButton(
            onPressed: _isSending 
              ? null
              : () {
                if (_cardNumberController.text.isEmpty || _cvvController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Verifica los datos")));
                  return;
                }
                _processPaymentAndSendEmailAutomatic();
              },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.accent, foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
            child: Text(_isSending ? "PROCESANDO..." : "PAGAR AHORA", style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }

  void _processPaymentAndSendEmailAutomatic() async {
    setState(() {
      _isSending = true;
    });

    String itemsList = "";
    for (var item in CartService.items) {
      itemsList += "- ${item.name}: ${item.price}\n";
    }

    // TUS CLAVES CORRECTAS
    const serviceId = 'service_vhef46p';
    const templateId = 'template_my09eym';
    const userId = 'HCZOvtqVyVpzCGuF_';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'origin': 'http://localhost',
        },
        body: json.encode({
          // ESTOS NOMBRES DE LA IZQUIERDA NO SE TOCAN, SON FIJOS:
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'nombre': _cardHolderController.text,
            'direccion': widget.direccionEnvio,
            'productos': itemsList,
            'total': CartService.getTotal(),
            'email_usuario': 'ale86867@gmail.com', 
          }
        }),
      );

      if (response.statusCode == 200) {
        if (!mounted) return;
        _showSuccessDialog();
      } else {
        print("Error EmailJS: ${response.body}");
        if (!mounted) return;
        // Si falla el correo, mostramos error pero dejamos terminar la compra
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Error de conexión con el correo, pero tu compra fue procesada.")));
        _showSuccessDialog();
      }

    } catch (e) {
      print("Error de conexión: $e");
      if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Error de conexión.")));
        _showSuccessDialog(); // Dejamos pasar al usuario
    } finally {
      if (mounted) {
        setState(() {
          _isSending = false;
        });
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surface,
        title: const Column(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 60),
            SizedBox(height: 10),
            Text("¡Pago Exitoso!", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
        content: const Text(
          "El recibo se ha enviado automáticamente a tu correo.\nTu pedido está en proceso.",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () {
              CartService.clear(); 
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                (route) => false,
              );
            },
            child: const Text("IR A MIS PEDIDOS", style: TextStyle(color: AppTheme.accent, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}