import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/auth_provider.dart';
import 'provider/book_provider.dart';
import 'provider/loan_provider.dart';
import 'views/auth/login_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => BookProvider()),
        ChangeNotifierProvider(create: (_) => LoanProvider()),
      ],
      child: const BookLendingApp(),
    ),
  );
}

class BookLendingApp extends StatelessWidget {
  const BookLendingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Peminjaman Buku UKK',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}