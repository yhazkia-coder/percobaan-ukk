import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/auth_provider.dart';
import '../../models/user_model.dart';
import 'register_screen.dart';
import '../member/member_dashboard.dart';
import '../admin/admin_dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController(text: 'member@perpus.com');

  void _handleLogin() {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    bool success = auth.login(_emailController.text, '');
    if (success) {
      final user = auth.currentUser!;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => user.role == UserRole.admin ? const AdminDashboard() : const MemberDashboard(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Email tidak ditemukan!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login - Peminjaman Buku')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.library_books, size: 80, color: Colors.blue),
            const SizedBox(height: 20),
            TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email')),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _handleLogin, child: const Text('Login')),
            TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen())),
              child: const Text('Belum punya akun? Register'),
            ),
          ],
        ),
      ),
    );
  }
}