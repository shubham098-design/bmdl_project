import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:b_m_digital_utilization/core/models/product_model.dart';

const _cartStorageKey = 'cart_items';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Future<List<ProductModel>> _loadCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final savedCart = prefs.getString(_cartStorageKey);
    if (savedCart == null || savedCart.isEmpty) return [];
    try {
      final decoded = jsonDecode(savedCart);
      if (decoded is List) {
        return decoded
            .whereType<Map<String, dynamic>>()
            .map(ProductModel.fromJson)
            .toList();
      }
    } catch (_) {
      return [];
    }
    return [];
  }

  Future<void> _refreshCartItems() async {
    setState(() {});
  }

  Future<void> _removeCartItem(ProductModel item) async {
    final prefs = await SharedPreferences.getInstance();
    final savedCart = prefs.getString(_cartStorageKey);
    if (savedCart == null || savedCart.isEmpty) return;

    try {
      final decoded = jsonDecode(savedCart);
      if (decoded is List) {
        final updatedItems = <Map<String, dynamic>>[];
        var removed = false;

        for (final entry in decoded) {
          if (removed) {
            if (entry is Map<String, dynamic>) {
              updatedItems.add(entry);
            } else if (entry is Map) {
              updatedItems.add(Map<String, dynamic>.from(entry));
            }
            continue;
          }

          if (entry is Map<String, dynamic>) {
            final id = entry['id'];
            if (id == item.id) {
              removed = true;
              continue;
            }
            updatedItems.add(entry);
          } else if (entry is Map) {
            final map = Map<String, dynamic>.from(entry);
            final id = map['id'];
            if (id == item.id) {
              removed = true;
              continue;
            }
            updatedItems.add(map);
          } else {
            updatedItems.add(Map<String, dynamic>.from(entry as Map));
          }
        }

        await prefs.setString(_cartStorageKey, jsonEncode(updatedItems));
        if (mounted) {
          _refreshCartItems();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${item.title} removed from cart'),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (_) {
      return;
    }
  }

  double _totalPrice(List<ProductModel> items) {
    return items.fold(0.0, (sum, item) => sum + (item.price ?? 0.0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff0f4ff),
      body: SafeArea(
        bottom: true,
        top: false,
        child: Stack(
          children: [
            /// BACKGROUND CIRCLES
            Positioned(
              top: -60,
              right: -40,
              child: Container(
                height: 220,
                width: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xff2563eb).withOpacity(0.10),
                ),
              ),
            ),
            Positioned(
              bottom: 120,
              left: -70,
              child: Container(
                height: 260,
                width: 260,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xff2563eb).withOpacity(0.07),
                ),
              ),
            ),

            SafeArea(
              child: FutureBuilder<List<ProductModel>>(
                future: _loadCartItems(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xff2563eb),
                      ),
                    );
                  }

                  final cartItems = snapshot.data ?? [];

                  return Column(
                    children: [
                      /// TOP HEADER
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'My Cart',
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xff0f172a),
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (cartItems.isNotEmpty)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xff2563eb,
                                  ).withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '${cartItems.length} item${cartItems.length > 1 ? 's' : ''}',
                                  style: const TextStyle(
                                    color: Color(0xff2563eb),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// EMPTY STATE
                      if (cartItems.isEmpty)
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xff2563eb,
                                    ).withOpacity(0.10),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.shopping_cart_outlined,
                                    size: 46,
                                    color: Color(0xff2563eb),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                const Text(
                                  'Your cart is empty',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xff0f172a),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Add products to get started',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      else ...[
                        /// CART ITEMS LIST
                        Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            itemCount: cartItems.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 14),
                            itemBuilder: (context, index) {
                              final item = cartItems[index];
                              return _buildCartItem(item);
                            },
                          ),
                        ),

                        /// BOTTOM CHECKOUT SECTION
                        Container(
                          margin: const EdgeInsets.all(20),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(28),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(
                                  0xff2563eb,
                                ).withOpacity(0.10),
                                blurRadius: 24,
                                offset: const Offset(0, -4),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              /// SUBTOTAL ROW
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Subtotal',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade500,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    '\$${_totalPrice(cartItems).toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xff0f172a),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),

                              /// SHIPPING ROW
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Shipping',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade500,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const Text(
                                    'Free',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xff16a34a),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                child: Divider(
                                  color: Colors.grey.shade100,
                                  thickness: 1.5,
                                ),
                              ),

                              /// TOTAL ROW
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Total',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff0f172a),
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Text(
                                    '\$${_totalPrice(cartItems).toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 22,
                                      color: Color(0xff2563eb),
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 18),

                              /// CHECKOUT BUTTON
                              SizedBox(
                                width: double.infinity,
                                height: 54,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff2563eb),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.lock_outline_rounded,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'Proceed to Checkout',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 0.2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItem(ProductModel item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff2563eb).withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 5),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          /// IMAGE BOX
          Container(
            width: 90,
            height: 90,
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xfff0f4ff),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(10),
            child: item.image != null && item.image!.isNotEmpty
                ? Image.network(item.image!, fit: BoxFit.contain)
                : const Icon(Icons.image_not_supported, color: Colors.grey),
          ),

          /// DETAILS
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title ?? 'Unknown Product',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff0f172a),
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 6),

                  /// RATING
                  if (item.rating != null)
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: Colors.amber,
                          size: 14,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          '${item.rating?.rate ?? 0}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                  const SizedBox(height: 8),

                  Text(
                    '\$${item.price?.toStringAsFixed(2) ?? '0.00'}',
                    style: const TextStyle(
                      fontSize: 17,
                      color: Color(0xff2563eb),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// DELETE BUTTON
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: GestureDetector(
              onTap: () => _removeCartItem(item),
              child: Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.delete_outline_rounded,
                  color: Colors.redAccent,
                  size: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
