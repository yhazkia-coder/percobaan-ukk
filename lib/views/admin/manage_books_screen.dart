import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/book_provider.dart';
import '../../models/book_model.dart';

class ManageBooksScreen extends StatelessWidget {
  const ManageBooksScreen({super.key});

  void _showBookDialog(BuildContext context, {Book? book}) {
    final titleController = TextEditingController(text: book?.title ?? '');
    final authorController = TextEditingController(text: book?.author ?? '');
    final categoryController = TextEditingController(text: book?.category ?? '');
    final stockController = TextEditingController(text: book?.stock.toString() ?? '1');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(book == null ? 'Tambah Buku' : 'Edit Buku'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Judul')),
            TextField(controller: authorController, decoration: const InputDecoration(labelText: 'Penulis')),
            TextField(controller: categoryController, decoration: const InputDecoration(labelText: 'Kategori')),
            TextField(controller: stockController, decoration: const InputDecoration(labelText: 'Stok'), keyboardType: TextInputType.number),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () {
              final newBook = Book(
                id: book?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
                title: titleController.text,
                author: authorController.text,
                category: categoryController.text,
                synopsis: 'Sinopsis buku baru...',
                stock: int.tryParse(stockController.text) ?? 1,
                imageUrl: 'https://picsum.photos/seed/${titleController.text}/200/300',
              );
              if (book == null) {
                Provider.of<BookProvider>(context, listen: false).addBook(newBook);
              } else {
                Provider.of<BookProvider>(context, listen: false).updateBook(newBook);
              }
              Navigator.pop(context);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Manajemen Data Buku')),
      body: ListView.builder(
        itemCount: bookProvider.books.length,
        itemBuilder: (context, index) {
          final book = bookProvider.books[index];
          return ListTile(
            title: Text(book.title),
            subtitle: Text('Stok: ${book.stock}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(icon: const Icon(Icons.edit, color: Colors.blue), onPressed: () => _showBookDialog(context, book: book)),
                IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => bookProvider.deleteBook(book.id)),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showBookDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}