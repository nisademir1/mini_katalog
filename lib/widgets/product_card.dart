import 'package:flutter/material.dart';

import '../models/product.dart';
import '../theme/app_theme.dart';
import 'product_image.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card: ürün görselinin gri, köşeleri yuvarlak kutusu
          Expanded(
            child: Card(
              margin: EdgeInsets.zero,
              elevation: 0,
              color: AppTheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                // Align: görseli kartın ortasına hizalar
                child: Align(
                  alignment: Alignment.center,
                  child: Hero(
                    tag: 'product-${product.id}',
                    child: ProductImage(product: product),
                  ),
                ),
              ),
            ),
          ),
          // margin: yazıları karttan biraz aşağı iter
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryText,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  product.tagline,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.secondaryText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  product.price,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.accent,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
