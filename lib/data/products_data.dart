import 'package:flutter/material.dart';

import '../models/product.dart';

final List<Product> productsData = [
  Product(
    id: 1,
    name: 'Mouse Gamer RGB',
    description: 'Mouse inalámbrico con sensor óptico de alta precisión y luces RGB personalizables.',
    price: 29.99,
    category: 'Ratones',
    imageUrl: 'https://img.pikbest.com/png-images/20250909/ergonomic-gaming-mouse-with-rgb-lighting-isolated-on-transparent-background_11878476.jpg%21bw700',
    color: Colors.deepPurple.shade100,
  ),
  Product(
    id: 2,
    name: 'Mouse Ergonómico',
    description: 'Diseño vertical para reducir la tensión en la muñeca. Ideal para largas jornadas.',
    price: 19.99,
    category: 'Ratones',
    imageUrl: 'https://1801889e95b1f9bf.kinxzone.com/webfile/product/11/11567/o2sl1u67vq51.jpg',
    color: Colors.blue.shade100,
  ),
  Product(
    id: 3,
    name: 'Teclado Mecánico',
    description: 'Teclado con switches azules, retroiluminación RGB y estructura de aluminio resistente.',
    price: 59.99,
    category: 'Teclados',
    imageUrl: 'https://images.unsplash.com/photo-1595225476474-87563907a212?q=80&w=500&auto=format&fit=crop',
    color: Colors.orange.shade100,
  ),
  Product(
    id: 4,
    name: 'Teclado Inalámbrico',
    description: 'Teclado slim ultradelgado, conexión Bluetooth y batería de larga duración.',
    price: 45.99,
    category: 'Teclados',
    imageUrl: 'https://images.unsplash.com/photo-1587829741301-dc798b83add3?q=80&w=500&auto=format&fit=crop',
    color: Colors.brown.shade100,
  ),
  Product(
    id: 5,
    name: 'Mousepad XL',
    description: 'Alfombrilla extendida de tela suave con base antideslizante, perfecta para teclado y mouse.',
    price: 12.99,
    category: 'Accesorios',
    imageUrl: 'https://i5.walmartimages.ca/asr/217eb62f-1364-494c-8fce-56c878b2b0bc.5d25fe21cf8b59c0b804a07c747d38c4.jpeg',
    color: Colors.green.shade100,
  ),
  Product(
    id: 6,
    name: 'Base para Laptop',
    description: 'Soporte de aluminio ajustable para mejorar la refrigeración y la postura de tu portátil.',
    price: 24.99,
    category: 'Accesorios',
    imageUrl: 'https://img.yfisher.com/1659428636911.png',
    color: Colors.pink.shade100,
  ),
];
