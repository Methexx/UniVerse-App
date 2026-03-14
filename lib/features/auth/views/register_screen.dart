import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: const Color(0xFFF0FBFF),
      ),
      backgroundColor: const Color(0xFFF0FBFF),
      body: const Center(
        child: Text('Register Screen Placeholder'),
      ),
    );
  }
}
