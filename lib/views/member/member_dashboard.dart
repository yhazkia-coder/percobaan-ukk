import 'package:flutter/material.dart';
import 'book_catalog_screen.dart';
import 'loan_history_screen.dart';
import '../auth/login_screen.dart';
import 'package:provider/provider.dart';
import '../../provider/auth_provider.dart';

class MemberDashboard extends StatefulWidget {
  const MemberDashboard({super.key});

  @override
  State<MemberDashboard> createState() => _MemberDashboardState();
}

class _MemberDashboardState extends State<MemberDashboard> {
  int _currentIndex = 0;
  final List<Widget> _pages = [const BookCatalogScreen(), const LoanHistoryScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Anggota Perpustakaan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
            },
          )
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Katalog Buku'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat Peminjaman'),
        ],
      ),
    );
  }
}