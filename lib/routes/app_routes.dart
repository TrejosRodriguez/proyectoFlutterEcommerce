import 'package:flutter/material.dart';

import '../screens/cart_screen.dart';
import '../screens/checkout_screen.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/product_detail_screen.dart';
import '../screens/register_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String detail = '/detalle';
  static const String cart = '/carrito';
  static const String checkout = '/checkout';
  static const String login = '/login';
  static const String register = '/register';
  static const String orders = '/orders';

  static Map<String, WidgetBuilder> routes = {
    home: (context) => const HomeScreen(),
    detail: (context) => const ProductDetailScreen(),
    cart: (context) => const CartScreen(),
    checkout: (context) => const CheckoutScreen(),
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(),
    orders: (context) => const OrdersScreen(),
  };
}
