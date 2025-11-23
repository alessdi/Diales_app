import '../models/watch_model.dart';

class CartService {
  // Esta lista será accesible desde toda la app
  static final List<Watch> _cartItems = [];

  // Obtener los items
  static List<Watch> get items => _cartItems;

  // Agregar al carrito
  static void add(Watch watch) {
    _cartItems.add(watch);
  }

  // Eliminar del carrito
  static void remove(Watch watch) {
    _cartItems.remove(watch);
  }

  // Calcular el total (Truco: Limpiamos el signo de $ y las comas para sumar)
  static String getTotal() {
    double total = 0;
    for (var item in _cartItems) {
      String cleanPrice = item.price.replaceAll('\$', '').replaceAll(',', '');
      total += double.tryParse(cleanPrice) ?? 0;
    }
    // Formateamos de vuelta a dinero (simple)
    return "\$${total.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}";
  }
}