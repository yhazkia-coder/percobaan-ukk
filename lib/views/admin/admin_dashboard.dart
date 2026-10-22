import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/auth_provider.dart';
import '../../provider/loan_provider.dart';
import '../../models/loan_model.dart';
import '../auth/login_screen.dart';
import 'manage_books_screen.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final loanProvider = Provider.of<LoanProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Petugas / Admin'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_note),
            tooltip: 'Kelola Buku',
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ManageBooksScreen())),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: loanProvider.loans.length,
        itemBuilder: (context, index) {
          final loan = loanProvider.loans[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text('${loan.bookTitle} (${loan.userName})'),
              subtitle: Text('Status: ${loan.status.name.toUpperCase()}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (loan.status == LoanStatus.pending)
                    IconButton(
                      icon: const Icon(Icons.check, color: Colors.green),
                      onPressed: () => loanProvider.updateLoanStatus(loan.id, LoanStatus.borrowed),
                    ),
                  if (loan.status == LoanStatus.borrowed)
                    IconButton(
                      icon: const Icon(Icons.assignment_returned, color: Colors.blue),
                      onPressed: () => loanProvider.updateLoanStatus(loan.id, LoanStatus.returned),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}