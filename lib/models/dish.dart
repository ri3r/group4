// lib/models/dish.dart

class Dish {
  final String id;
  final String name;
  final double price;
  final String shortDescription;
  final String category;
  
  // FÜGE DIESE ZEILE HINZU
  // Wir machen es nullable (mit dem '?'), falls mal ein Gericht kein Bild hat.
  final String? imagePath; 

  const Dish({
    required this.id,
    required this.name,
    required this.price,
    required this.shortDescription,
    required this.category,
    
    // FÜGE DIESE ZEILE HINZU
    this.imagePath, 
  });
}