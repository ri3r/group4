// lib/screens/dish_details_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/dish.dart';

class DishDetailsScreen extends StatelessWidget {
  final Dish dish;

  const DishDetailsScreen({super.key, required this.dish});

  @override
  Widget build(BuildContext context) {
    const Color primaryGold = Color(0xFFB89047);
    const Color textDark = Color(0xFF3E2A1E);
    const Color textLight = Color(0xFF8A7A70);

    return Scaffold(
      appBar: AppBar(
        title: Text(dish.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (dish.imagePath != null)
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FullScreenImagePage(imagePath: dish.imagePath!),
                    ),
                  );
                },
                // Hero-Animation
                child: Hero(
                  tag: dish.imagePath!,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: primaryGold.withOpacity(0.3), width: 2),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5)),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.asset(
                        dish.imagePath!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),

            if (dish.imagePath == null)
               Container(
                  width: 120, height: 120,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: primaryGold.withOpacity(0.05)),
                  alignment: Alignment.center,
                  child: const Icon(Icons.restaurant, size: 48, color: primaryGold),
               ),
               
            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(color: primaryGold, borderRadius: BorderRadius.circular(20),),
              child: Text(dish.category.toUpperCase(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1.5),),
            ),
            const SizedBox(height: 24),
            Text(dish.name, textAlign: TextAlign.center, style: GoogleFonts.playfairDisplay(fontSize: 32, fontWeight: FontWeight.bold, color: textDark,),),
            const SizedBox(height: 16),
            Text('\$${dish.price.toStringAsFixed(2)}', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: primaryGold),),
            const SizedBox(height: 32),
            const Divider(color: Color(0xFFF0E6D8), thickness: 1),
            const SizedBox(height: 24),
            const Align(alignment: Alignment.centerLeft, child: Text('Description', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textDark),),),
            const SizedBox(height: 12),
            Text(dish.shortDescription, style: const TextStyle(fontSize: 16, height: 1.6, color: textLight),),
          ],
        ),
      ),
    );
  }
}

class FullScreenImagePage extends StatelessWidget {
  final String imagePath;

  const FullScreenImagePage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Hero(
          tag: imagePath,
          child: InteractiveViewer(
            panEnabled: true,
            minScale: 0.5,
            maxScale: 4.0,
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}