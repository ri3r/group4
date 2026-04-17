import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/menu_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const RestaurantApp());
}

class RestaurantApp extends StatelessWidget {
  const RestaurantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFAF5EE), 
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFB89047),
          primary: const Color(0xFFB89047),
          surface: Colors.white,
        ),
        textTheme: GoogleFonts.latoTextTheme().apply(
          bodyColor: const Color(0xFF8A7A70),
          displayColor: const Color(0xFF3E2A1E),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFFFAF5EE),
          foregroundColor: const Color(0xFF3E2A1E),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: GoogleFonts.playfairDisplay(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF3E2A1E),
          ),
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(color: Color(0xFFF0E6D8), width: 1),
          ),
        ),
      ),
      home: const MainNavigator(),
    );
  }
}

// Navigation widget
class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = <Widget>[
    HomeScreen(), // Unser modularer Home Screen
    MenuScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryGold = Color(0xFFB89047);
    const Color textLight = Color(0xFF8A7A70);

    return Scaffold(
      appBar: AppBar(
        title: const Text('The Golden Fork'),
      ),
      
      body: _screens.elementAt(_selectedIndex),
      
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Menu',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: primaryGold,
        unselectedItemColor: textLight, 
        onTap: _onItemTapped,
      ),
    );
  }
}