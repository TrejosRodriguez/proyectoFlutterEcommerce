import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../providers/order_provider.dart';
import '../models/order.dart';
import '../routes/app_routes.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _paymentMethods = const [
    'Tarjeta de crédito',
    'Tarjeta de débito',
    'Pago contra entrega',
  ];
  String _payment = 'Tarjeta de crédito';

  String? _orderNumber;
  double _paidTotal = 0;

  void _confirm(CartProvider cart, OrderProvider orders) {
    if (!_formKey.currentState!.validate()) return;

    final newOrder = Order(
      orderNumber: '#${10000 + Random().nextInt(90000)}',
      date: DateTime.now(),
      total: cart.total,
      items: cart.items.toList(),
    );

    setState(() {
      _orderNumber = newOrder.orderNumber;
      _paidTotal = cart.total;
    });

    orders.addOrder(newOrder);
    cart.clear();
  }

  @override
  Widget build(BuildContext context) {
    if (_orderNumber != null) return _buildConfirmation(context);

    final cart = context.watch<CartProvider>();

    if (cart.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Checkout')),
        body: Center(
          child: FilledButton(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.home,
              (route) => false,
            ),
            child: const Text('Ir a la tienda'),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const Text(
              'Datos de envío',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _field(
              'Nombre completo',
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Campo obligatorio';
                if (v.trim().length < 3) return 'Debe tener al menos 3 letras';
                return null;
              },
            ),
            const SizedBox(height: 12),
            _field(
              'Dirección',
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Campo obligatorio';
                if (v.trim().length < 3) return 'Debe tener al menos 3 letras';
                return null;
              },
            ),
            const SizedBox(height: 12),
            _field(
              'Teléfono',
              keyboard: TextInputType.phone,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Campo obligatorio';

                final phone = v.trim();
                final phoneRegex = RegExp(r'^[278]\d{7}$');

                if (!phoneRegex.hasMatch(phone)) {
                  return 'Debe tener 8 dígitos y empezar con 2, 7 u 8';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            const Text(
              'Método de pago',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _payment,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items: _paymentMethods
                  .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                  .toList(),
              onChanged: (v) => setState(() => _payment = v!),
            ),
            const SizedBox(height: 24),
            const Text(
              'Resumen del pedido',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    for (final item in cart.items)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${item.product.name} x${item.quantity}'),
                            Text('\$${item.subtotal.toStringAsFixed(2)}'),
                          ],
                        ),
                      ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '\$${cart.total.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton(
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
              backgroundColor: Colors.indigo,
            ),
            onPressed: () => _confirm(
              context.read<CartProvider>(),
              context.read<OrderProvider>(),
            ),
            child: const Text(
              'Confirmar pedido',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  Widget _field(
    String label, {
    TextInputType? keyboard,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      keyboardType: keyboard,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator:
          validator ??
          (v) => (v == null || v.trim().isEmpty) ? 'Campo obligatorio' : null,
    );
  }

  Widget _buildConfirmation(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 56,
              backgroundColor: Colors.green.shade50,
              child: const CircleAvatar(
                radius: 40,
                backgroundColor: Colors.green,
                child: Icon(Icons.check, size: 48, color: Colors.white),
              ),
            ),
            const SizedBox(height: 28),
            const Text(
              '¡Pedido confirmado!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Gracias por tu compra, te avisaremos\ncuando tu pedido sea enviado.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade700),
            ),
            const SizedBox(height: 28),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Número de pedido'),
                        Text(
                          '$_orderNumber',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total pagado'),
                        Text(
                          '\$${_paidTotal.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton(
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
              backgroundColor: Colors.indigo,
            ),
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.home,
              (route) => false,
            ),
            child: const Text(
              'Volver al inicio',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
