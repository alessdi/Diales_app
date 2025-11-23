class Watch {  // Clases 
  final String name; // Nombre del reloj
  final String price; // precio del reloj
  final String imagePath; // ruta al asset de imagen
  final String description; // descripcion del producto para la pantalla de detalles


// Constructor que requiere todos los campos obligatorios
  Watch({
    required this.name, 
    required this.price, 
    required this.imagePath,
    required this.description,
  });
}

final List<Watch> myWatches = [
  Watch(
    name: "Batman GMT", 
    price: "\$3,800", 
    imagePath: "assets/Batman.jpg",
    description: "Movimiento automático GMT. Bisel de cerámica bicolor negro y azul. Caja de acero inoxidable 904L de 40mm. Cristal de zafiro resistente a rayaduras. Resistente al agua 100m.",
  ),
  Watch(
    name: "Daytona Panda", 
    price: "\$3,500", 
    imagePath: "assets/DaytonaM.jpg",
    description: "Cronógrafo de alta precisión. Esfera blanca con subesferas negras en contraste. Bisel taquimétrico de cerámica negra. Brazalete Oyster cómodo y elegante.",
  ),
  Watch(
    name: "Submariner Date", 
    price: "\$3,500", 
    imagePath: "assets/Submariner.jpg",
    description: "El reloj de buceo por excelencia. Bisel giratorio unidireccional. Índices luminiscentes Chromalight. Ventana de fecha con lente Cyclops. Hermético hasta 300 metros.",
  ),
  Watch(
    name: "Datejust Blue", 
    price: "\$3,750", 
    imagePath: "assets/datejustblue.jpg",
    description: "Elegancia clásica. Esfera azul con acabado rayos de sol. Bisel estriado de oro blanco. Brazalete Jubilé de cinco eslabones. Calibre 3235 de nueva generación.",
  ),
  Watch(
    name: "Nautilus", 
    price: "\$3,800", 
    imagePath: "assets/NautilusOp.jpg",
    description: "Diseño icónico de ojo de buey. Esfera con relieve horizontal. Caja y brazalete integrados en acero. Fondo de caja de cristal de zafiro para ver el movimiento.",
  ),
  Watch(
    name: "Bruce Wayne", 
    price: "\$3,800", 
    imagePath: "assets/Bruce.jpg",
    description: "Edición especial GMT con bisel negro y gris. Estilo sobrio y misterioso. Perfecto para el viajero moderno que busca discreción y funcionalidad.",
  ),
  Watch(
    name: "Cartier Santos", 
    price: "\$3,800", 
    imagePath: "assets/Santos.jpg",
    description: "Diseño geométrico con tornillos visibles. Caja cuadrada de acero. Sistema SmartLink para ajuste de brazalete. Un clásico atemporal de la relojería francesa.",
  ),
  Watch(
    name: "Submariner Hulk", 
    price: "\$3,800", 
    imagePath: "assets/hulk.jpg",
    description: "Inconfundible esfera y bisel verdes. Apodo 'Hulk' por su robustez y color. Caja Maxi de 40mm con asas más anchas. Una pieza de colección muy codiciada.",
  ),
  Watch(
    name: "Royal Oak", 
    price: "\$3,800", 
    imagePath: "assets/oak.jpg",
    description: "Bisel octogonal con tornillos hexagonales. Esfera con patrón 'Grande Tapisserie'. Acabado cepillado y pulido a mano. Una obra maestra de diseño integrado.",
  ),
];