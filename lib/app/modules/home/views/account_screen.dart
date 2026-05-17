import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../routes/app_routes.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> accountOptions = [
      {
        "title": "My Orders",
        "icon": Icons.shopping_bag_outlined,
        "subtitle": "Track your orders",
        "color": const Color(0xff2563eb),
        "bg": const Color(0xffeff6ff),
        "isLogout": false,
      },
      {
        "title": "Wishlist",
        "icon": Icons.favorite_border,
        "subtitle": "12 saved items",
        "color": const Color(0xffdb2777),
        "bg": const Color(0xfffdf2f8),
        "isLogout": false,
      },
      {
        "title": "Saved Address",
        "icon": Icons.location_on_outlined,
        "subtitle": "Manage your addresses",
        "color": const Color(0xff0d9488),
        "bg": const Color(0xfff0fdfa),
        "isLogout": false,
      },
      {
        "title": "Payment Methods",
        "icon": Icons.credit_card_outlined,
        "subtitle": "Cards & wallets",
        "color": const Color(0xff7c3aed),
        "bg": const Color(0xfff5f3ff),
        "isLogout": false,
      },
      {
        "title": "Notifications",
        "icon": Icons.notifications_none,
        "subtitle": "Alerts & updates",
        "color": const Color(0xffea580c),
        "bg": const Color(0xfffff7ed),
        "isLogout": false,
      },
      {
        "title": "Help & Support",
        "icon": Icons.help_outline,
        "subtitle": "FAQs & contact us",
        "color": const Color(0xff16a34a),
        "bg": const Color(0xfff0fdf4),
        "isLogout": false,
      },
      {
        "title": "Settings",
        "icon": Icons.settings_outlined,
        "subtitle": "App preferences",
        "color": const Color(0xff64748b),
        "bg": const Color(0xfff8fafc),
        "isLogout": false,
      },
      {
        "title": "Logout",
        "icon": Icons.logout_rounded,
        "subtitle": "Sign out of account",
        "color": const Color(0xffe11d48),
        "bg": const Color(0xfffff1f2),
        "isLogout": true,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xfff0f4ff),
      body: SafeArea(
        bottom: true,
        top: false,
        child: Stack(
          children: [
            /// BACKGROUND CIRCLES
            Positioned(
              top: -40,
              right: -50,
              child: Container(
                height: 180,
                width: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xff2563eb).withOpacity(0.08),
                ),
              ),
            ),
            Positioned(
              bottom: 100,
              left: -60,
              child: Container(
                height: 220,
                width: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xff2563eb).withOpacity(0.06),
                ),
              ),
            ),

            Column(
              children: [
                /// TOP HEADER
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xff2563eb),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(36),
                      bottomRight: Radius.circular(36),
                    ),
                  ),
                  child: SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
                      child: Column(
                        children: [
                          /// TOP ROW
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'My Account',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -0.3,
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.edit_outlined,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 22),

                          /// AVATAR + NAME
                          Row(
                            children: [
                              /// AVATAR
                              Container(
                                height: 78,
                                width: 78,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(0.15),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.4),
                                    width: 2.5,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.person_rounded,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),

                              const SizedBox(width: 18),

                              /// NAME & EMAIL
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Shubham',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: -0.3,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'abc@gmail.com',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.8),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.18),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Text(
                                        '⭐ Premium Member',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          /// STATS ROW
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.13),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                _buildStat('25', 'Orders'),
                                _buildDivider(),
                                _buildStat('12', 'Wishlist'),
                                _buildDivider(),
                                _buildStat('8', 'Reviews'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// OPTIONS LIST
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: accountOptions.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final item = accountOptions[index];
                      final color = item["color"] as Color;
                      final bg = item["bg"] as Color;
                      final isLogout = item["isLogout"] as bool;

                      return GestureDetector(
                        onTap: () async {
                          if (isLogout) {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.clear();
                            Get.offAllNamed(Routes.login);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: color.withOpacity(0.08),
                                blurRadius: 14,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                            child: Row(
                              children: [
                                /// ICON
                                Container(
                                  height: 48,
                                  width: 48,
                                  decoration: BoxDecoration(
                                    color: bg,
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Icon(
                                    item["icon"] as IconData,
                                    color: color,
                                    size: 22,
                                  ),
                                ),

                                const SizedBox(width: 14),

                                /// TEXT
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item["title"],
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15,
                                          color: isLogout
                                              ? const Color(0xffe11d48)
                                              : const Color(0xff0f172a),
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        item["subtitle"],
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade500,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                /// ARROW
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: bg,
                                    borderRadius: BorderRadius.circular(9),
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 13,
                                    color: color,
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

                const SizedBox(height: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildStat(String value, String label) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildDivider() {
    return Container(
      height: 36,
      width: 1.2,
      color: Colors.white.withOpacity(0.25),
    );
  }
}
