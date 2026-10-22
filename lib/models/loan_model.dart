enum LoanStatus { pending, borrowed, returned }

class Loan {
  final String id;
  final String userId;
  final String userName;
  final String bookId;
  final String bookTitle;
  final DateTime loanDate;
  LoanStatus status;

  Loan({
    required this.id,
    required this.userId,
    required this.userName,
    required this.bookId,
    required this.bookTitle,
    required this.loanDate,
    required this.status,
  });
}
