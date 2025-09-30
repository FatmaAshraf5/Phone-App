// lib/pages/welcome_page.dart
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  void navigate(BuildContext context, String route) {
    Navigator.of(context).pushNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyle(
      fontFamily: 'Suwannaphum',
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Colors.deepPurple.shade700,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Aesthetic Shop'),
        centerTitle: true,
        elevation: 2,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text('Welcome', style: titleStyle, textAlign: TextAlign.center),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // local image
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(blurRadius: 6, color: Colors.black12),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/photoo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // online image
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(blurRadius: 6, color: Colors.black12),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=800&q=80',
                        fit: BoxFit.cover,
                        errorBuilder: (ctx, e, st) => Container(
                          color: Colors.grey.shade200,
                          child: const Center(child: Icon(Icons.broken_image)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Text(
                'Discover beautiful products',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => navigate(context, '/signup'),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text('Sign Up'),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => navigate(context, '/signin'),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text('Sign In'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
