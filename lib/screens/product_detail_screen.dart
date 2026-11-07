import 'package:flutter/material.dart';

import '../models/product.dart';
import '../routes/app_routes.dart';
import '../services/cart_service.dart';
import '../theme/app_theme.dart';
import '../widgets/cart_badge_button.dart';
import '../widgets/product_image.dart';
import '../widgets/spec_chip.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final CartService _cart = CartService.instance;

  void _addToCart(Product product) {
    setState(() {
      _cart.add(product);
    });

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('${product.name} added to cart'),
          duration: const Duration(seconds: 2),
          action: SnackBarAction(
            label: 'VIEW CART',
            onPressed: () => Navigator.pushNamed(context, AppRoutes.cart),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    // Ana sayfadan route argument olarak gelen ürün
    final product = ModalRoute.of(context)!.settings.arguments as Product;
    final quantity = _cart.quantityOf(product);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Back'),
        titleSpacing: 0,
        actions: const [CartBadgeButton()],
      ),
      body: ListView(
        children: [
          Container(
            height: 320,
            width: double.infinity,
            color: AppTheme.surface,
            padding: const EdgeInsets.all(24),
            child: Hero(
              tag: 'product-${product.id}',
              child: ProductImage(product: product),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.primaryText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  product.tagline,
                  style: const TextStyle(color: AppTheme.secondaryText),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Description',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Text(
                  product.description,
                  style: const TextStyle(
                    height: 1.5,
                    color: Color(0xFF3A3A3C),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Specifications',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: product.specs.entries
                      .map((e) => SpecChip(label: e.key, value: e.value))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Price',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.secondaryText,
                    ),
                  ),
                  Text(
                    product.price,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: FilledButton(
                  onPressed: () => _addToCart(product),
                  child: Text(
                    quantity == 0
                        ? 'Add to Cart'
                        : 'Add to Cart ($quantity in cart)',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
