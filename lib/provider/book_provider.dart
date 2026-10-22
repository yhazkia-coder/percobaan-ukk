import 'package:flutter/material.dart';
import '../models/book_model.dart';

class BookProvider with ChangeNotifier {
  final List<Book> _books = [
    Book(
      id: 'b1',
      title: 'Pemrograman Flutter & Dart',
      author: 'Ahmad Arifin',
      category: 'Teknologi',
      synopsis: 'Buku panduan lengkap membangun aplikasi mobile multi-platform menggunakan framework Flutter.',
      stock: 5,
      imageUrl: 'https://picsum.photos/seed/flutter/200/300',
    ),
    Book(
      id: 'b2',
      title: 'Algoritma & Struktur Data',
      author: 'Dewi Lestari',
      category: 'Akademik',
      synopsis: 'Mempelajari logika dasar pemrograman, sorting, searching, hingga struktur tree dan graph.',
      stock: 2,
      imageUrl: 'https://picsum.photos/seed/algo/200/300',
    ),
  ];

  List<Book> get books => _books;

  void addBook(Book book) {
    _books.add(book);
    notifyListeners();
  }

  void updateBook(Book updatedBook) {
    final index = _books.indexWhere((b) => b.id == updatedBook.id);
    if (index != -1) {
      _books[index] = updatedBook;
      notifyListeners();
    }
  }

  void deleteBook(String id) {
    _books.removeWhere((b) => b.id == id);
    notifyListeners();
  }
}