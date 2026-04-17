// lib/data/dummy_data.dart

import '../models/dish.dart';

const List<Dish> dummyMenu = [
  // Starters
  Dish(
    id: 's1',
    name: 'Tomato Soup',
    price: 5.50,
    shortDescription: 'Homemade tomato soup served with fresh basil.',
    category: 'Starters',
    imagePath: 'lib/assets/images/tomatensoupe.png',
  ),
  Dish(
    id: 's2',
    name: 'Bruschetta',
    price: 6.90,
    shortDescription: 'Toasted bread topped with tomatoes, garlic, and olive oil.',
    category: 'Starters',
    imagePath: 'lib/assets/images/bruschetta.png',
  ),

  // Main Courses
  Dish(
    id: 'm1',
    name: 'Pizza Margherita',
    price: 10.50,
    shortDescription: 'Classic pizza with tomato sauce and fresh mozzarella.',
    category: 'Main Courses',
    imagePath: 'lib/assets/images/pizza.png',
  ),
  Dish(
    id: 'm2',
    name: 'Spaghetti Carbonara',
    price: 12.00,
    shortDescription: 'Spaghetti with pancetta, egg, parmesan cheese, and black pepper.',
    category: 'Main Courses',
    imagePath: 'lib/assets/images/carbonara.png',
  ),

  // Desserts
  Dish(
    id: 'd1',
    name: 'Tiramisu',
    price: 6.50,
    shortDescription: 'Classic Italian dessert made with coffee and mascarpone.',
    category: 'Desserts',
    imagePath: 'lib/assets/images/tiramisu.png',
  ),

  // Drinks
  Dish(
    id: 'dr1',
    name: 'Homemade Lemonade',
    price: 4.50,
    shortDescription: 'Refreshing lemon lemonade with fresh mint.',
    category: 'Drinks',
    imagePath: 'lib/assets/images/lemonade.png',
  ),
];