import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universe_app/features/auth/viewmodels/auth_viewmodel.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String? userEmail = context.select<AuthViewModel, String?>(
      (AuthViewModel vm) => vm.currentUser?.email,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Signed in as: ${userEmail ?? "unknown"}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            const Text('MVVM foundation is ready. Next: feature screens.'),
          ],
        ),
      ),
    );
  }
}
