import 'cart_item.dart';

class Order {
  final String orderNumber;
  final DateTime date;
  final double total;
  final List<CartItem> items;

  Order({
    required this.orderNumber,
    required this.date,
    required this.total,
    required this.items,
  });

  Map<String, dynamic> toJson() => {
    'orderNumber': orderNumber,
    'date': date.toIso8601String(),
    'total': total,
    'items': items.map((item) => item.toJson()).toList(),
  };

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderNumber: json['orderNumber'],
      date: DateTime.parse(json['date']),
      total: json['total'].toDouble(),
      items: (json['items'] as List)
          .map((item) => CartItem.fromJson(item))
          .toList(),
    );
  }
}
