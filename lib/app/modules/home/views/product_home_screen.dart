import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:b_m_digital_utilization/core/models/product_model.dart';
import '../controllers/product_controller.dart';
import 'product_detail_screen.dart';

class ProductHomeScreen extends StatelessWidget {
  const ProductHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.put(ProductController());

    return Scaffold(
      backgroundColor: const Color(0xfff8fafc),
      body: SafeArea(
        bottom: true,
        top: false,
        child: Obx(() {
          if (controller.isLoading.value && controller.products.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xff2563eb)),
            );
          }

          if (controller.errorMessage.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 65, color: Colors.red),
                  const SizedBox(height: 18),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      controller.errorMessage.value,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => controller.fetchProducts(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff2563eb),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 26,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Retry',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          }

          return LayoutBuilder(
            builder: (context, innerConstraints) {
              final screenWidth = innerConstraints.maxWidth;
              const crossAxisCount = 2;
              final childAspectRatio = screenWidth >= 900
                  ? 0.75
                  : screenWidth >= 600
                  ? 0.69
                  : 0.62;
              final horizontalPadding = screenWidth >= 900 ? 28.0 : 16.0;
              final topHorizontalPadding = screenWidth >= 900 ? 34.0 : 20.0;
              final topBottomPadding = screenWidth >= 900 ? 32.0 : 28.0;
              final titleFontSize = screenWidth >= 900 ? 34.0 : 28.0;
              final subtitleFontSize = screenWidth >= 900 ? 18.0 : 16.0;

              return Column(
                children: [
                  /// TOP SECTION
                  Container(
                    padding: EdgeInsets.fromLTRB(
                      topHorizontalPadding,
                      20,
                      topHorizontalPadding,
                      topBottomPadding,
                    ),
                    decoration: const BoxDecoration(
                      color: Color(0xff2563eb),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(34),
                        bottomRight: Radius.circular(34),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// HEADER
                        const SizedBox(height: 25),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hello Shubham 👋',
                                    style: TextStyle(
                                      color: const Color.fromRGBO(
                                        255,
                                        255,
                                        255,
                                        0.9,
                                      ),
                                      fontSize: subtitleFontSize,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Find Your Style',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: titleFontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              height: 52,
                              width: 52,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(
                                  255,
                                  255,
                                  255,
                                  0.18,
                                ),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: const Icon(
                                Icons.notifications_none,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 28),

                        /// SEARCH FIELD
                        Container(
                          height: 58,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromRGBO(0, 0, 0, 0.06),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: TextField(
                            onChanged: controller.searchProducts,
                            decoration: InputDecoration(
                              hintText: 'Search products...',
                              hintStyle: TextStyle(color: Colors.grey.shade500),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Color(0xff2563eb),
                              ),
                              suffixIcon: Container(
                                margin: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(0xff2563eb),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: const Icon(
                                  Icons.tune,
                                  color: Colors.white,
                                ),
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  /// CATEGORY CHIPS
                  SizedBox(
                    height: 42,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                      ),
                      children: [
                        _buildCategoryChip(title: 'All', isSelected: true),
                        _buildCategoryChip(title: 'Fashion'),
                        _buildCategoryChip(title: 'Electronics'),
                        _buildCategoryChip(title: 'Shoes'),
                        _buildCategoryChip(title: 'Beauty'),
                        _buildCategoryChip(title: 'Watches'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  /// PRODUCT GRID
                  Expanded(
                    child: controller.products.isEmpty
                        ? Center(
                            child: Text(
                              'No products found',
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        : GridView.builder(
                            padding: EdgeInsets.symmetric(
                              horizontal: horizontalPadding,
                            ),
                            itemCount: controller.products.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: crossAxisCount,
                                  childAspectRatio: childAspectRatio,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 18,
                                ),
                            itemBuilder: (context, index) {
                              final product = controller.products[index];

                              return _buildProductCard(context, product);
                            },
                          ),
                  ),
                ],
              );
            },
          );
        }),
      ),
    );
  }

  Widget _buildCategoryChip({required String title, bool isSelected = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xff2563eb) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, ProductModel product) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => ProductDetailScreen(product: product),
          transition: Transition.rightToLeft,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),
          boxShadow: [
            BoxShadow(
              color: const Color.fromRGBO(0, 0, 0, 0.05),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// IMAGE SECTION
            Expanded(
              flex: 6,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: const Color(0xfff8fafc),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Image.network(
                      product.image ?? '',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(
                            Icons.image_not_supported,
                            size: 40,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),

                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      height: 38,
                      width: 38,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.favorite_border,
                        size: 20,
                        color: Color(0xff2563eb),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// DETAILS
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  12,
                  6,
                  12,
                  8,
                ), // ← padding kam kiya
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12, // ← 13 → 12
                        fontWeight: FontWeight.w600,
                        height: 1.2, // ← 1.3 → 1.2
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: Colors.amber,
                          size: 15,
                        ), // ← 18 → 15
                        const SizedBox(width: 3),
                        Text(
                          '${product.rating?.rate ?? 0.0}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ), // ← 13 → 12
                        const Spacer(),
                        Text(
                          '(${product.rating?.count ?? 0})',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 11,
                          ),
                        ), // ← 12 → 11
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '\$${product.price?.toStringAsFixed(2) ?? '0.00'}',
                          style: const TextStyle(
                            color: Color(0xff2563eb),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ), // ← 17 → 15
                        const Spacer(),
                        Container(
                          height: 32,
                          width: 32, // ← 36 → 32
                          decoration: BoxDecoration(
                            color: const Color(0xff2563eb),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.add_shopping_cart,
                            color: Colors.white,
                            size: 16,
                          ),
                        ), // ← 18 → 16
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
