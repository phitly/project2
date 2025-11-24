import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Mental Zen'),
        backgroundColor: Colors.teal.shade400,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authProvider.signOut();
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                size: 80,
                color: Colors.green.shade400,
              ),
              const SizedBox(height: 24),
              Text(
                'Welcome to Mental Zen!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade700,
                ),
              ),
              const SizedBox(height: 16),
              if (user?.displayName != null)
                Text(
                  'Hello, ${user!.displayName}!',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey.shade700,
                  ),
                ),
              const SizedBox(height: 8),
              Text(
                user?.email ?? '',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.teal.shade100),
                ),
                child: Text(
                  'Authentication successful! 🎉\n\nYour secure wellness hub will be built here.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.teal.shade700,
                    fontSize: 14,
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
