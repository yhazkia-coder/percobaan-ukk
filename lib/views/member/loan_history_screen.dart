import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/auth_provider.dart';
import '../../provider/loan_provider.dart';
import '../../models/loan_model.dart';

class LoanHistoryScreen extends StatelessWidget {
  const LoanHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final loanProvider = Provider.of<LoanProvider>(context);
    final userLoans = loanProvider.getUserLoans(auth.currentUser!.id);

    return ListView.builder(
      itemCount: userLoans.length,
      itemBuilder: (context, index) {
        final loan = userLoans[index];
        return Card(
          margin: const EdgeInsets.all(8),
          child: ListTile(
            title: Text(loan.bookTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Tanggal: ${loan.loanDate.toLocal().toString().split(' ')[0]}'),
            trailing: Chip(
              label: Text(
                loan.status == LoanStatus.pending
                    ? 'Menunggu'
                    : loan.status == LoanStatus.borrowed
                        ? 'Dipinjam'
                        : 'Dikembalikan',
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: loan.status == LoanStatus.pending
                  ? Colors.orange
                  : loan.status == LoanStatus.borrowed
                      ? Colors.blue
                      : Colors.green,
            ),
          ),
        );
      },
    );
  }
}