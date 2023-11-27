import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  int _counter = 0;

  User? get user => _user;
  int get counter => _counter;

  final AuthService _authService = AuthService();

  Future<void> loginUser(String email, String password) async {
    try {
      final isAuthenticated = await _authService.authenticate(email, password);

      if (isAuthenticated) {
        _user = User(email, password);
        notifyListeners();
      } else {
        throw Exception('Credenciais inválidas');
      }
    } catch (e) {
      throw Exception('Erro durante a autenticação: $e');
    }
  }

  void logoutUser() {
    _user = null;
    _counter = 0;
    notifyListeners();
  }

  void incrementCounter() {
    _counter++;
    notifyListeners();
  }

  void resetCounter() {
    _counter = 0;
    notifyListeners();
  }
}
