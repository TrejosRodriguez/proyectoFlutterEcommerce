import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/order_provider.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Escuchamos el provider de pedidos
    final orders = context.watch<OrderProvider>().orders;

    return Scaffold(
      appBar: AppBar(title: const Text('Mis Pedidos')),
      body: orders.isEmpty
          ? const Center(
              child: Text(
                'Aún no tienes pedidos',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: const Icon(
                      Icons.receipt_long,
                      size: 40,
                      color: Colors.indigo,
                    ),
                    title: Text('Pedido ${order.orderNumber}'),
                    subtitle: Text(
                      // Formateamos la fecha (Ej: 24/05/2024 - 03:30 PM)
                      DateFormat('dd/MM/yyyy - hh:mm a').format(order.date),
                    ),
                    trailing: Text(
                      '\$${order.total.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.indigo,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
