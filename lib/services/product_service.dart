import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../models/product.dart';

class ProductService {
  static const String _path = 'assets/data/products.json';

  static Future<List<Product>> loadProducts() async {
    final raw = await rootBundle.loadString(_path);
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    final list = decoded['data'] as List<dynamic>;
    return list
        .map((item) => Product.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
