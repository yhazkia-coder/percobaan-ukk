import 'package:flutter/material.dart';
import '../models/loan_model.dart';

class LoanProvider with ChangeNotifier {
  final List<Loan> _loans = [
    Loan(
      id: 'l1',
      userId: 'u1',
      userName: 'Budi (Anggota)',
      bookId: 'b1',
      bookTitle: 'Pemrograman Flutter & Dart',
      loanDate: DateTime.now().subtract(const Duration(days: 2)),
      status: LoanStatus.borrowed,
    ),
  ];

  List<Loan> get loans => _loans;

  List<Loan> getUserLoans(String userId) {
    return _loans.where((l) => l.userId == userId).toList();
  }

  void requestLoan(String userId, String userName, String bookId, String bookTitle) {
    _loans.add(Loan(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      userName: userName,
      bookId: bookId,
      bookTitle: bookTitle,
      loanDate: DateTime.now(),
      status: LoanStatus.pending,
    ));
    notifyListeners();
  }

  void updateLoanStatus(String loanId, LoanStatus newStatus) {
    final loan = _loans.firstWhere((l) => l.id == loanId);
    loan.status = newStatus;
    notifyListeners();
  }
}