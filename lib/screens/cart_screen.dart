import 'package:flutter/material.dart';

import '../routes/app_routes.dart';
import '../services/cart_service.dart';
import '../theme/app_theme.dart';
import '../utils/formatters.dart';
import '../widgets/cart_item_tile.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  void _checkout(BuildContext context, CartService cart) {
    final total = formatPrice(cart.totalPrice);
    final count = cart.totalCount;
    cart.clear();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Order received'),
        content: Text(
          '$count item(s), total $total.\n\n'
          'This is a simulation, no real payment was taken.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = CartService.instance;

    return ListenableBuilder(
      listenable: cart,
      builder: (context, _) {
        final items = cart.items;

        return Scaffold(
          appBar: AppBar(title: const Text('Cart')),
          body: cart.isEmpty
              ? const _EmptyCart()
              : ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return CartItemTile(
                      item: item,
                      onRemove: () => cart.removeOne(item.product),
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.detail,
                        arguments: item.product,
                      ),
                    );
                  },
                ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.surface,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 18,
                          color: AppTheme.secondaryText,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Demo checkout. No real payment is made.',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppTheme.secondaryText,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (!cart.isEmpty) ...[
                    Row(
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          formatPrice(cart.totalPrice),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                  FilledButton(
                    onPressed:
                        cart.isEmpty ? null : () => _checkout(context, cart),
                    child: const Text('Checkout'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 56,
            color: AppTheme.secondaryText,
          ),
          SizedBox(height: 12),
          Text(
            'Your cart is empty',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 4),
          Text(
            'Add items to start shopping',
            style: TextStyle(color: AppTheme.secondaryText),
          ),
        ],
      ),
    );
  }
}
