import 'package:flutter/material.dart';

import 'routes/app_routes.dart';
import 'screens/cart_screen.dart';
import 'screens/home_screen.dart';
import 'screens/product_detail_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Katalog',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: AppRoutes.home,

      // Named Routes: isimle açılan sayfalar
      routes: {
        AppRoutes.home: (context) => const HomeScreen(),
        AppRoutes.cart: (context) => const CartScreen(),
      },

      // Detay sayfası: MaterialPageRoute ile oluşturulur,
      // route arguments (ürün) settings içinde taşınır
      onGenerateRoute: (settings) {
        if (settings.name == AppRoutes.detail) {
          return MaterialPageRoute(
            builder: (context) => const ProductDetailScreen(),
            settings: settings,
          );
        }
        return null;
      },
    );
  }
}
