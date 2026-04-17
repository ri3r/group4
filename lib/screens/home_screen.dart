// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryGold = Color(0xFFB89047);
    const Color textDark = Color(0xFF3E2A1E);
    const Color textLight = Color(0xFF8A7A70);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 4),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5)),
              ],
            ),
            child: const CircleAvatar(
              radius: 80,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('lib/assets/images/logo.png'),
            ),
          ),
          const SizedBox(height: 24),

          Text(
            'Benvenuto!',
            style: GoogleFonts.playfairDisplay(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: textDark,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Welcome to The Golden Fork! We serve the finest Italian cuisine in town. Every dish is prepared with passion and the freshest ingredients.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, height: 1.5, color: textLight),
          ),
          const SizedBox(height: 32),

          Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: primaryGold.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.access_time, color: primaryGold),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Opening Hours', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textDark)),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('Mo - Fr', style: TextStyle(color: textLight)),
                            Text('11:00 - 22:00', style: TextStyle(fontWeight: FontWeight.bold, color: textDark)),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('Sa - Su', style: TextStyle(color: textLight)),
                            Text('12:00 - 23:00', style: TextStyle(fontWeight: FontWeight.bold, color: textDark)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Card(
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              onTap: () async {
                final Uri url = Uri.parse('https://www.google.com/maps/search/?api=1&query=Marktplatz+1,+97070+Würzburg');

                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                } else {
                  debugPrint('Error opening Google Maps.');
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: primaryGold.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.location_on, color: primaryGold),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Location', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textDark)),
                          SizedBox(height: 4),
                          Text('Marktplatz 1\n97070 Würzburg', style: TextStyle(color: textLight, height: 1.4)),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: textLight),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}