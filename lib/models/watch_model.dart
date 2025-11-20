class Watch {
  final String name;
  final String price;
  final String imagePath;

  Watch({required this.name, required this.price, required this.imagePath});
}

// --- AQUÍ ES DONDE EDITAS LOS NOMBRES Y PRECIOS ---
final List<Watch> myWatches = [
  // --- MODELOS EXISTENTES ---
  Watch(
    name: "Batman GMT", 
    price: "\$3,800", 
    imagePath: "assets/Batman.jpg"
  ),
  Watch(
    name: "Daytona Panda", 
    price: "\$3,500", 
    imagePath: "assets/DaytonaM.jpg"
  ),
  Watch(
    name: "Submariner Date", 
    price: "\$3,500", 
    imagePath: "assets/Submariner.jpg.webp"
  ),
  Watch(
    name: "Datejust Blue", 
    price: "\$3,750", 
    imagePath: "assets/datejustblue.jpg.webp"
  ),
  Watch(
    name: "Nautilus", 
    price: "\$3,800", 
    imagePath: "assets/NautilusOp.jpg.webp"
  ),
  Watch(
    name: "Bruce Wayne", 
    price: "\$3,800", 
    imagePath: "assets/Bruce.jpg"
  ),

  // --- NUEVOS MODELOS AGREGADOS ---
  Watch(
    name: "Santos", 
    price: "\$3,800", 
    imagePath: "assets/Santos.jpg.webp"
  ),
  Watch(
    name: "Submariner Hulk", 
    price: "\$3,800", 
    imagePath: "assets/hulk.jpg"
  ),
  Watch(
    name: "Royal Oak", 
    price: "\$3,800", 
    imagePath: "assets/oak.jpg"
  ),
];