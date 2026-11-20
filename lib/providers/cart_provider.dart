import 'package:flutter/foundation.dart';

import '../models/cart_item.dart';
import '../models/product.dart';

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CartProvider extends ChangeNotifier {
  final Map<int, CartItem> _items = {};

  // 1. Carga los datos al iniciar la app
  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cartString = prefs.getString('cart_data');

    if (cartString != null) {
      final List<dynamic> decodedList = jsonDecode(cartString);
      for (var itemJson in decodedList) {
        final item = CartItem.fromJson(itemJson);
        _items[item.product.id] = item;
      }
      notifyListeners(); // Avisa a la pantalla que ya hay datos
    }
  }

  // 2. Guarda los datos cada vez que hay un cambio
  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final String cartString = jsonEncode(
      _items.values.map((item) => item.toJson()).toList(),
    );
    await prefs.setString('cart_data', cartString);
  }

  List<CartItem> get items => _items.values.toList();

  bool get isEmpty => _items.isEmpty;

  int get totalCount =>
      _items.values.fold(0, (sum, item) => sum + item.quantity);

  double get total =>
      _items.values.fold(0.0, (sum, item) => sum + item.subtotal);

  void add(Product product, {int quantity = 1}) {
    if (_items.containsKey(product.id)) {
      _items[product.id]!.quantity += quantity;
    } else {
      _items[product.id] = CartItem(product: product, quantity: quantity);
    }
    _saveCart();
    notifyListeners();
  }

  void increment(int productId) {
    _items[productId]?.quantity++;
    notifyListeners();
  }

  void decrement(int productId) {
    final item = _items[productId];
    if (item == null) return;

    if (item.quantity > 1) {
      item.quantity--;
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void remove(int productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
