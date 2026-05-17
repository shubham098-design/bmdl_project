import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff0f4ff),
      body: Stack(
        children: [
          /// BACKGROUND DECORATION
          Positioned(
            top: -80,
            right: -60,
            child: Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xff2563eb).withOpacity(0.12),
              ),
            ),
          ),
          Positioned(
            top: 60,
            right: 40,
            child: Container(
              height: 140,
              width: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xff2563eb).withOpacity(0.08),
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            left: -60,
            child: Container(
              height: 320,
              width: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xff2563eb).withOpacity(0.10),
              ),
            ),
          ),

          /// MAIN CONTENT
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final maxWidth = constraints.maxWidth > 600
                    ? 480.0
                    : constraints.maxWidth * 0.92;

                return Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 32,
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: maxWidth),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// LOGO / ICON
                          Center(
                            child: Container(
                              height: 72,
                              width: 72,
                              decoration: BoxDecoration(
                                color: const Color(0xff2563eb),
                                borderRadius: BorderRadius.circular(22),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(
                                      0xff2563eb,
                                    ).withOpacity(0.35),
                                    blurRadius: 20,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.storefront_rounded,
                                color: Colors.white,
                                size: 36,
                              ),
                            ),
                          ),

                          const SizedBox(height: 28),

                          /// HEADING
                          const Center(
                            child: Text(
                              'Welcome Back',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                                color: Color(0xff0f172a),
                                letterSpacing: -0.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Center(
                            child: Text(
                              'Sign in to continue shopping',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),

                          const SizedBox(height: 36),

                          /// CARD
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(28),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xff2563eb,
                                  ).withOpacity(0.08),
                                  blurRadius: 30,
                                  offset: const Offset(0, 10),
                                ),
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Form(
                              key: controller.formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// EMAIL FIELD
                                  const Text(
                                    'Email Address',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff334155),
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  TextFormField(
                                    controller: controller.emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Color(0xff0f172a),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'you@example.com',
                                      hintStyle: TextStyle(
                                        color: Colors.grey.shade400,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      prefixIcon: Container(
                                        margin: const EdgeInsets.all(10),
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: const Color(
                                            0xff2563eb,
                                          ).withOpacity(0.10),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.email_outlined,
                                          color: Color(0xff2563eb),
                                          size: 18,
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: const Color(0xfff8faff),
                                      contentPadding:
                                      const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 16,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(14),
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade200,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(14),
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade200,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(14),
                                        borderSide: const BorderSide(
                                          color: Color(0xff2563eb),
                                          width: 1.8,
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(14),
                                        borderSide: const BorderSide(
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(14),
                                        borderSide: const BorderSide(
                                          color: Colors.redAccent,
                                          width: 1.8,
                                        ),
                                      ),
                                    ),
                                    validator: controller.validateEmail,
                                    autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                  ),

                                  const SizedBox(height: 20),

                                  /// PASSWORD FIELD
                                  const Text(
                                    'Password',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff334155),
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  TextFormField(
                                    controller: controller.passwordController,
                                    obscureText: true,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Color(0xff0f172a),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: '••••••••',
                                      hintStyle: TextStyle(
                                        color: Colors.grey.shade400,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      prefixIcon: Container(
                                        margin: const EdgeInsets.all(10),
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: const Color(
                                            0xff2563eb,
                                          ).withOpacity(0.10),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.lock_outline_rounded,
                                          color: Color(0xff2563eb),
                                          size: 18,
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: const Color(0xfff8faff),
                                      contentPadding:
                                      const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 16,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(14),
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade200,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(14),
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade200,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(14),
                                        borderSide: const BorderSide(
                                          color: Color(0xff2563eb),
                                          width: 1.8,
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(14),
                                        borderSide: const BorderSide(
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(14),
                                        borderSide: const BorderSide(
                                          color: Colors.redAccent,
                                          width: 1.8,
                                        ),
                                      ),
                                    ),
                                    validator: controller.validatePassword,
                                    autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                  ),

                                  const SizedBox(height: 28),

                                  /// LOGIN BUTTON
                                  Obx(
                                        () => SizedBox(
                                      width: double.infinity,
                                      height: 54,
                                      child: ElevatedButton(
                                        onPressed: controller.isLoading.value
                                            ? null
                                            : controller.login,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(
                                            0xff2563eb,
                                          ),
                                          disabledBackgroundColor: const Color(
                                            0xff2563eb,
                                          ).withOpacity(0.6),
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                          ),
                                          shadowColor: const Color(
                                            0xff2563eb,
                                          ).withOpacity(0.4),
                                        ),
                                        child: controller.isLoading.value
                                            ? const SizedBox(
                                          height: 22,
                                          width: 22,
                                          child:
                                          CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2.5,
                                          ),
                                        )
                                            : const Text(
                                          'Sign In',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 0.3,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          /// DEMO CREDENTIALS HINT
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xff2563eb).withOpacity(0.07),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0xff2563eb).withOpacity(0.15),
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.info_outline_rounded,
                                  color: Color(0xff2563eb),
                                  size: 18,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: RichText(
                                    text: const TextSpan(
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Color(0xff334155),
                                      ),
                                      children: [
                                        TextSpan(text: 'Demo: '),
                                        TextSpan(
                                          text: 'abc@gmail.com',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff2563eb),
                                          ),
                                        ),
                                        TextSpan(text: '  /  '),
                                        TextSpan(
                                          text: '123456',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff2563eb),
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
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
/*
class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Sign in'), centerTitle: true),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth > 600
              ? 520.0
              : constraints.maxWidth * 0.92;
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome Back',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Sign in with your email and password to continue.',
                            style: theme.textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 28),
                          TextFormField(
                            controller: controller.emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              hintText: 'you@example.com',
                              prefixIcon: const Icon(Icons.email_outlined),
                            ),
                            validator: controller.validateEmail,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: controller.passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: const Icon(Icons.lock_outline),
                            ),
                            validator: controller.validatePassword,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                          const SizedBox(height: 24),
                          Obx(
                            () => SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: ElevatedButton(
                                onPressed: controller.isLoading.value
                                    ? null
                                    : controller.login,
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: controller.isLoading.value
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : const Text('Log in'),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Use'),
                              Text(
                                'abc@gmail.com',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(' / '),
                              Text(
                                '123456',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

 */
