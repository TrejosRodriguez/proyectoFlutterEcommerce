import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_dev/models/product.dart';
import 'package:ecommerce_dev/providers/cart_provider.dart';
import 'package:flutter/material.dart';

void main() {
  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
  });

  final testProduct = Product(
    id: 1,
    name: 'Mouse de prueba',
    description: 'Solo para tests',
    price: 10.0,
    category: 'Test',
    imageUrl: 'url_falsa',
    color: Colors.blue,
  );

  group('Pruebas del CartProvider', () {
    test('Debe agregar un producto y calcular el total', () {
      final cart = CartProvider();

      cart.add(testProduct);

      expect(cart.items.length, 1);
      expect(cart.totalCount, 1);
      expect(cart.total, 10.0);
    });

    test('Debe incrementar y decrementar la cantidad correctamente', () {
      final cart = CartProvider();
      cart.add(testProduct);

      cart.increment(testProduct.id);
      expect(cart.totalCount, 2);
      expect(cart.total, 20.0);

      cart.decrement(testProduct.id);
      expect(cart.totalCount, 1);
      expect(cart.total, 10.0);
    });

    test('Debe eliminar el producto si la cantidad baja a cero', () {
      final cart = CartProvider();
      cart.add(testProduct);

      cart.decrement(testProduct.id);

      expect(cart.items.isEmpty, true);
      expect(cart.total, 0.0);
    });

    test('Debe vaciar el carrito con el método clear', () {
      final cart = CartProvider();
      cart.add(testProduct, quantity: 5);

      expect(cart.totalCount, 5);

      cart.clear();

      expect(cart.items.isEmpty, true);
      expect(cart.total, 0.0);
    });
  });
}
