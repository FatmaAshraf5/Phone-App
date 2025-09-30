// lib/widgets/product_card.dart
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final VoidCallback onAdd;

  const ProductCard({super.key, required this.product, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 6,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
              child: Image.network(
                product['imageUrl'],
                fit: BoxFit.cover,
                errorBuilder: (ctx, e, st) => Container(
                  color: Colors.grey.shade200,
                  child: const Center(child: Icon(Icons.image_not_supported)),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      product['title'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    onPressed: onAdd,
                    icon: const Icon(Icons.add_shopping_cart),
                    tooltip: 'Add to cart',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
