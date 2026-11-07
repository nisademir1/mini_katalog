import 'package:flutter/material.dart';

import '../models/product.dart';
import '../theme/app_theme.dart';

class ProductImage extends StatelessWidget {
  final Product product;
  final BoxFit fit;

  const ProductImage({
    super.key,
    required this.product,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      product.imageAsset,
      fit: fit,
      errorBuilder: (context, error, stackTrace) => const Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          color: AppTheme.secondaryText,
          size: 40,
        ),
      ),
    );
  }
}
