import 'package:flutter/material.dart';
import '../models/user_model.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _currentUser;
  
  // Dummy registered users database
  final List<UserModel> _registeredUsers = [
    UserModel(id: 'u1', name: 'Budi (Anggota)', email: 'member@perpus.com', role: UserRole.member),
    UserModel(id: 'u2', name: 'Admin Perpus', email: 'admin@perpus.com', role: UserRole.admin),
  ];

  UserModel? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;

  bool login(String email, String roleStr) {
    try {
      final user = _registeredUsers.firstWhere((u) => u.email == email);
      _currentUser = user;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  bool register(String name, String email, UserRole role) {
    if (_registeredUsers.any((u) => u.email == email)) return false;
    final newUser = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: email,
      role: role,
    );
    _registeredUsers.add(newUser);
    _currentUser = newUser;
    notifyListeners();
    return true;
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}