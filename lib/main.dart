import 'package:flutter/material.dart';
import 'pages/menu_list_page.dart';
import 'pages/menu_detail_page.dart';
import 'pages/order_page.dart';

void main() {
  runApp(const MyApp());
}

const Color kForest = Color(0xFF174B38);
const Color kForestDark = Color(0xFF103728);
const Color kCream = Color(0xFFFAF6EC);
const Color kCard = Color(0xFFFFFEFA);
const Color kOrange = Color(0xFFD95732);
const Color kText = Color(0xFF202720);
const Color kMuted = Color(0xFF77786F);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kantin Bu Sari',
      debugShowCheckedModeBanner: false,

      // Tema aplikasi
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: kForest,
          primary: kForest,
          secondary: kOrange,
          surface: kCream,
        ),
        scaffoldBackgroundColor: kCream,
        fontFamily: 'Roboto',

        appBarTheme: const AppBarTheme(
          backgroundColor: kCream,
          foregroundColor: kText,
          elevation: 0,
          centerTitle: false,
        ),

        cardTheme: CardThemeData(
          color: kCard,
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: const BorderSide(color: Color(0xFFEDE6D8)),
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF2EDE2),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: kForest, width: 1.5),
          ),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kOrange,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            textStyle: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),

        chipTheme: ChipThemeData(
          backgroundColor: const Color(0xFFF0E9DB),
          selectedColor: kForest,
          labelStyle: const TextStyle(fontSize: 13),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          side: BorderSide.none,
        ),
      ),

      // Navigasi halaman, dipertahankan dari kode awal
      initialRoute: '/',
      routes: {
        '/': (context) => const MenuListPage(),
        '/detail': (context) => const MenuDetailPage(),
        '/pesan': (context) => const OrderPage(),
      },
    );
  }
}