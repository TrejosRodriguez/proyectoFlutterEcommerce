import 'package:flutter/foundation.dart';

import '../data/products_data.dart';
import '../models/product.dart';

class CatalogProvider extends ChangeNotifier {
  String _query = '';
  String _category = 'Todos';

  String get category => _category;

  List<String> get categories => [
    'Todos',
    ...productsData.map((p) => p.category).toSet(),
  ];

  List<Product> get products {
    return productsData.where((p) {
      final matchesCategory = _category == 'Todos' || p.category == _category;
      final matchesQuery = p.name.toLowerCase().contains(_query.toLowerCase());
      return matchesCategory && matchesQuery;
    }).toList();
  }

  Product? findById(int id) {
    for (final p in productsData) {
      if (p.id == id) return p;
    }
    return null;
  }

  void setQuery(String value) {
    _query = value;
    notifyListeners();
  }

  void setCategory(String value) {
    _category = value;
    notifyListeners();
  }
}
