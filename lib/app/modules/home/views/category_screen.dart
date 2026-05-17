import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {
        "title": "Men Fashion",
        "icon": Icons.checkroom,
        "items": "120+ Items",
        "color": const Color(0xff2563eb),
        "bg": const Color(0xffeff6ff),
      },
      {
        "title": "Women Fashion",
        "icon": Icons.shopping_bag,
        "items": "220+ Items",
        "color": const Color(0xffdb2777),
        "bg": const Color(0xfffdf2f8),
      },
      {
        "title": "Electronics",
        "icon": Icons.headphones,
        "items": "80+ Items",
        "color": const Color(0xff7c3aed),
        "bg": const Color(0xfff5f3ff),
      },
      {
        "title": "Shoes",
        "icon": Icons.hiking,
        "items": "60+ Items",
        "color": const Color(0xffea580c),
        "bg": const Color(0xfffff7ed),
      },
      {
        "title": "Watches",
        "icon": Icons.watch,
        "items": "40+ Items",
        "color": const Color(0xff0d9488),
        "bg": const Color(0xfff0fdfa),
      },
      {
        "title": "Beauty",
        "icon": Icons.brush,
        "items": "95+ Items",
        "color": const Color(0xffe11d48),
        "bg": const Color(0xfffff1f2),
      },
      {
        "title": "Furniture",
        "icon": Icons.chair_alt,
        "items": "35+ Items",
        "color": const Color(0xff92400e),
        "bg": const Color(0xfffffbeb),
      },
      {
        "title": "Gaming",
        "icon": Icons.sports_esports,
        "items": "50+ Items",
        "color": const Color(0xff16a34a),
        "bg": const Color(0xfff0fdf4),
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xfff0f4ff),
      body: SafeArea(
        bottom: true,
        top: false,
        child: Stack(
          children: [
            /// BACKGROUND DECORATION
            Positioned(
              top: -50,
              right: -50,
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xff2563eb).withOpacity(0.09),
                ),
              ),
            ),
            Positioned(
              bottom: 80,
              left: -60,
              child: Container(
                height: 240,
                width: 240,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xff2563eb).withOpacity(0.06),
                ),
              ),
            ),

            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// HEADER
                    Row(
                      children: [
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Categories',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xff0f172a),
                                  letterSpacing: -0.5,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'What are you looking for?',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff64748b),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 46,
                          width: 46,
                          decoration: BoxDecoration(
                            color: const Color(0xff2563eb),
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(
                                  0xff2563eb,
                                ).withOpacity(0.35),
                                blurRadius: 14,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.grid_view_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    /// SEARCH BAR
                    Container(
                      height: 54,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xff2563eb).withOpacity(0.08),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search categories...",
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          prefixIcon: Container(
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              color: const Color(0xff2563eb).withOpacity(0.10),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.search_rounded,
                              color: Color(0xff2563eb),
                              size: 18,
                            ),
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// TOTAL COUNT LABEL
                    Row(
                      children: [
                        const Text(
                          'All Categories',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff0f172a),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xff2563eb).withOpacity(0.12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${categories.length}',
                            style: const TextStyle(
                              color: Color(0xff2563eb),
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    /// GRID
                    Expanded(
                      child: GridView.builder(
                        itemCount: categories.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                              childAspectRatio: 0.92,
                            ),
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          final color = category["color"] as Color;
                          final bg = category["bg"] as Color;

                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  BoxShadow(
                                    color: color.withOpacity(0.10),
                                    blurRadius: 16,
                                    offset: const Offset(0, 6),
                                  ),
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.03),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// ICON BOX
                                    Container(
                                      height: 58,
                                      width: 58,
                                      decoration: BoxDecoration(
                                        color: bg,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Icon(
                                        category["icon"] as IconData,
                                        color: color,
                                        size: 28,
                                      ),
                                    ),

                                    const Spacer(),

                                    /// TITLE
                                    Text(
                                      category["title"],
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xff0f172a),
                                        height: 1.2,
                                      ),
                                    ),

                                    const SizedBox(height: 4),

                                    /// ITEM COUNT
                                    Text(
                                      category["items"],
                                      style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),

                                    const SizedBox(height: 12),

                                    /// EXPLORE BUTTON
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 7,
                                      ),
                                      decoration: BoxDecoration(
                                        color: bg,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Explore',
                                            style: TextStyle(
                                              color: color,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12,
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Icon(
                                            Icons.arrow_forward_rounded,
                                            size: 13,
                                            color: color,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
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
