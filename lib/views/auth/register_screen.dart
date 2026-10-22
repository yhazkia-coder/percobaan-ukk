import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/auth_provider.dart';
import '../../models/user_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  UserRole _selectedRole = UserRole.member;

  void _handleRegister() {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    bool success = auth.register(_nameController.text, _emailController.text, _selectedRole);
    if (success) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registrasi Berhasil! Silakan Login.')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Email sudah terdaftar!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register Akun Baru')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Nama Lengkap')),
            TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email')),
            DropdownButtonFormField<UserRole>(
              value: _selectedRole,
              items: const [
                DropdownMenuItem(value: UserRole.member, child: Text('Anggota')),
                DropdownMenuItem(value: UserRole.admin, child: Text('Petugas / Admin')),
              ],
              onChanged: (val) => setState(() => _selectedRole = val!),
              decoration: const InputDecoration(labelText: 'Hak Akses (Role)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _handleRegister, child: const Text('Daftar')),
          ],
        ),
      ),
    );
  }
}