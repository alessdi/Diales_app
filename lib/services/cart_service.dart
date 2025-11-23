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

  //Función para vaciar el carrito al comprar
  static void clear() {
    _cartItems.clear();
  }

  // Calcular el total
  static String getTotal() {
    double total = 0;
    for (var item in _cartItems) {
      String cleanPrice = item.price.replaceAll('\$', '').replaceAll(',', '');
      total += double.tryParse(cleanPrice) ?? 0;
    }
    // Formateamos de vuelta a dinero 
    return "\$${total.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}";
  }
}