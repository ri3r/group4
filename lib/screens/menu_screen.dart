// lib/screens/menu_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/dummy_data.dart';
import 'dish_details_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color textDark = Color(0xFF3E2A1E);
    const Color primaryGold = Color(0xFFB89047);
    const Color textLight = Color(0xFF8A7A70);

    Widget buildCategorySection(String categoryName) {
      final categoryDishes = dummyMenu.where((dish) => dish.category == categoryName).toList();

      if (categoryDishes.isEmpty) return const SizedBox.shrink();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 24, bottom: 12),
            child: Text(
              categoryName,
              style: GoogleFonts.playfairDisplay(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: textDark,
              ),
            ),
          ),
          ...categoryDishes.map((dish) {
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DishDetailsScreen(dish: dish),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFFF0E6D8), width: 1), 
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: dish.imagePath != null
                              ? Image.asset(
                                  dish.imagePath!,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  color: primaryGold.withOpacity(0.15),
                                  alignment: Alignment.center,
                                  child: const Icon(Icons.restaurant, color: primaryGold),
                                ),
                        ),
                      ),
                      const SizedBox(width: 16),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dish.name,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textDark),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              dish.shortDescription,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 13, color: textLight),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),

                      Text(
                        '\$${dish.price.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryGold),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ],
      );
    }

    return ListView(
      padding: const EdgeInsets.only(bottom: 32),
      children: [
        buildCategorySection('Starters'),
        buildCategorySection('Main Courses'),
        buildCategorySection('Desserts'),
        buildCategorySection('Drinks'),
      ],
    );
  }
}