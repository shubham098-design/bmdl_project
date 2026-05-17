import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:b_m_digital_utilization/core/models/product_model.dart';

const _cartStorageKey = 'cart_items';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Details'), elevation: 0),
      body: SafeArea(
        bottom: true,
        top: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image Section
              Container(
                height: 300,
                width: double.infinity,
                color: Colors.grey[100],
                child: Image.network(
                  product.image ?? '',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Icon(
                        Icons.image_not_supported,
                        color: Colors.grey[400],
                        size: 80,
                      ),
                    );
                  },
                ),
              ),
              // Product Details Section
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        product.category ?? 'N/A',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Product Title
                    Text(
                      product.title ?? '',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Rating Section
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 191, 0, 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${product.rating?.rate ?? 0.0}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${product.rating?.count ?? 0} reviews',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Price Section
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Price: ',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        Text(
                          '\$${product.price?.toStringAsFixed(2) ?? '0.00'}',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Description Section
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.description ?? '',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Add to Cart Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () async {
                          final messenger = ScaffoldMessenger.of(context);
                          final prefs = await SharedPreferences.getInstance();
                          final savedCart = prefs.getString(_cartStorageKey);
                          final cartItems = <Map<String, dynamic>>[];

                          if (savedCart != null && savedCart.isNotEmpty) {
                            try {
                              final decoded = jsonDecode(savedCart);
                              if (decoded is List) {
                                for (final item in decoded) {
                                  if (item is Map<String, dynamic>) {
                                    cartItems.add(item);
                                  } else if (item is Map) {
                                    cartItems.add(
                                      Map<String, dynamic>.from(item),
                                    );
                                  }
                                }
                              }
                            } catch (_) {
                              cartItems.clear();
                            }
                          }

                          cartItems.add(product.toJson());
                          await prefs.setString(
                            _cartStorageKey,
                            jsonEncode(cartItems),
                          );

                          messenger.showSnackBar(
                            SnackBar(
                              content: Text('${product.title} added to cart'),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.shopping_cart),
                            SizedBox(width: 8),
                            Text('Add to Cart'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
