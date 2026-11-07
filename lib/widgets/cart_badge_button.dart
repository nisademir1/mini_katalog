import 'package:flutter/material.dart';

import '../routes/app_routes.dart';
import '../services/cart_service.dart';

class CartBadgeButton extends StatelessWidget {
  const CartBadgeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = CartService.instance;
    return ListenableBuilder(
      listenable: cart,
      builder: (context, _) {
        final count = cart.totalCount;
        return IconButton(
          onPressed: () => Navigator.pushNamed(context, AppRoutes.cart),
          icon: Badge(
            isLabelVisible: count > 0,
            label: Text('$count'),
            child: const Icon(Icons.shopping_bag_outlined),
          ),
        );
      },
    );
  }
}
