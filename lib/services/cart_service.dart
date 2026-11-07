import 'package:flutter/foundation.dart';

import '../models/cart_item.dart';
import '../models/product.dart';

class CartService extends ChangeNotifier {
  CartService._();
  static final CartService instance = CartService._();

  final Map<int, CartItem> _items = {};

  List<CartItem> get items => _items.values.toList();
  bool get isEmpty => _items.isEmpty;

  int get totalCount =>
      _items.values.fold<int>(0, (sum, item) => sum + item.quantity);

  double get totalPrice =>
      _items.values.fold<double>(0, (sum, item) => sum + item.total);

  int quantityOf(Product product) => _items[product.id]?.quantity ?? 0;

  void add(Product product) {
    final item = _items[product.id];
    if (item == null) {
      _items[product.id] = CartItem(product: product);
    } else {
      item.quantity++;
    }
    notifyListeners();
  }

  void removeOne(Product product) {
    final item = _items[product.id];
    if (item == null) return;
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      _items.remove(product.id);
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
