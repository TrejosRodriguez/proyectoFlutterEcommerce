import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/order.dart';

class OrderProvider extends ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders => _orders.reversed.toList();

  Future<void> loadOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final String? ordersString = prefs.getString('orders_data');

    if (ordersString != null) {
      final List<dynamic> decodedList = jsonDecode(ordersString);
      _orders.clear();
      for (var orderJson in decodedList) {
        _orders.add(Order.fromJson(orderJson));
      }
      notifyListeners();
    }
  }

  Future<void> addOrder(Order order) async {
    _orders.add(order);
    await _saveOrders();
    notifyListeners();
  }

  Future<void> _saveOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final String ordersString = jsonEncode(
      _orders.map((order) => order.toJson()).toList(),
    );
    await prefs.setString('orders_data', ordersString);
  }
}
