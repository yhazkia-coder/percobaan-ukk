import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/book_provider.dart';
import 'book_detail_screen.dart';

class BookCatalogScreen extends StatefulWidget {
  const BookCatalogScreen({super.key});

  @override
  State<BookCatalogScreen> createState() => _BookCatalogScreenState();
}

class _BookCatalogScreenState extends State<BookCatalogScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);
    final filteredBooks = bookProvider.books.where((book) {
      return book.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          book.category.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: const InputDecoration(labelText: 'Cari berdasarkan judul atau kategori', prefixIcon: Icon(Icons.search), border: OutlineInputBorder()),
            onChanged: (val) => setState(() => _searchQuery = val),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredBooks.length,
            itemBuilder: (context, index) {
              final book = filteredBooks[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ListTile(
                  leading: Image.network(book.imageUrl, width: 50, fit: BoxFit.cover),
                  title: Text(book.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Penulis: ${book.author} | Stok: ${book.stock}'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => BookDetailScreen(book: book))),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}