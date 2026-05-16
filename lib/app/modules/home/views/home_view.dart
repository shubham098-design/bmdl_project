import 'package:flutter/material.dart';

// Home Screen

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.check_circle_outline, color: Colors.green, size: 96),
              SizedBox(height: 24),
              Text(
                'Login successful!',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),
              Text(
                'Welcome to the app. Your authentication flow is ready.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,

              ),
            ],
          ),
        ),
      ),
    );
  }
}





