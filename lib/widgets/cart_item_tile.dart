import 'package:flutter/material.dart';

import '../models/cart_item.dart';
import '../theme/app_theme.dart';
import 'product_image.dart';

class CartItemTile extends StatelessWidget {
  final CartItem item;
  final VoidCallback onRemove;
  final VoidCallback onTap;

  const CartItemTile({
    super.key,
    required this.item,
    required this.onRemove,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final product = item.product;
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        width: 56,
        height: 56,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ProductImage(product: product),
      ),
      title: Text(
        product.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            product.tagline,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: AppTheme.secondaryText, fontSize: 12),
          ),
          const SizedBox(height: 2),
          Text(
            '${product.price}  ×${item.quantity}',
            style: const TextStyle(
              color: AppTheme.primaryText,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      trailing: IconButton(
        onPressed: onRemove,
        icon: const Icon(Icons.remove_circle_outline),
        color: AppTheme.secondaryText,
      ),
    );
  }
}
