// lib/pages/signup_page.dart
import 'package:flutter/material.dart';
import 'homepage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  @override
  void dispose() {
    _fullNameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  bool _firstLetterUpper(String s) {
    if (s.isEmpty) return false;
    final first = s[0];
    return first == first.toUpperCase();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Account created successfully'),
          content: const Text('Your account has been created.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop(); // close dialog
                // Fade to home
                Navigator.of(context).pushAndRemoveUntil(
                  PageRouteBuilder(
                    pageBuilder: (c, a1, a2) => const HomePage(),
                    transitionsBuilder: (c, anim, a2, child) {
                      return FadeTransition(opacity: anim, child: child);
                    },
                    transitionDuration: const Duration(milliseconds: 600),
                  ),
                  (route) => false,
                );
              },
              child: const Text('Close'),
            ),
          ],
        ),
      );
    }
  }

  String? _validateName(String? v) {
    if (v == null || v.trim().isEmpty) return 'Please enter your full name';
    if (!_firstLetterUpper(v.trim())) return 'First letter must be uppercase';
    return null;
  }

  String? _validateEmail(String? v) {
    if (v == null || v.trim().isEmpty) return 'Please enter your email';
    if (!v.contains('@')) return 'Email must include @';
    return null;
  }

  String? _validatePassword(String? v) {
    if (v == null || v.isEmpty) return 'Please enter a password';
    if (v.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  String? _validateConfirm(String? v) {
    if (v == null || v.isEmpty) return 'Please confirm password';
    if (v != _passwordCtrl.text) return 'Passwords do not match';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _fullNameCtrl,
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: _validateName,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailCtrl,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _passwordCtrl,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: _validatePassword,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _confirmCtrl,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                ),
                obscureText: true,
                validator: _validateConfirm,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text('Create Account'),
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
