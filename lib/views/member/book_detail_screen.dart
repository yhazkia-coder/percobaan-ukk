import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/book_model.dart';
import '../../provider/auth_provider.dart';
import '../../provider/loan_provider.dart';

class BookDetailScreen extends StatelessWidget {
  final Book book;
  const BookDetailScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final loanProvider = Provider.of<LoanProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text(book.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.network(book.imageUrl, height: 180, fit: BoxFit.cover)),
            const SizedBox(height: 16),
            Text('Kategori: ${book.category}', style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
            Text('Penulis: ${book.author}', style: const TextStyle(fontSize: 16)),
            Text('Stok Tersedia: ${book.stock}', style: const TextStyle(fontSize: 16)),
            const Divider(height: 24),
            const Text('Sinopsis:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Text(book.synopsis),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.bookmark_add),
                label: const Text('Ajukan Peminjaman Buku'),
                onPressed: book.stock > 0
                    ? () {
                        loanProvider.requestLoan(auth.currentUser!.id, auth.currentUser!.name, book.id, book.title);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pengajuan peminjaman berhasil dikirim!')));
                        Navigator.pop(context);
                      }
                    : null,
              ),
            )
          ],
        ),
      ),
    );
  }
}