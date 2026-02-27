import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/firebase_service.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();
  User? _user;

  AuthProvider() {
    _firebaseService.user.listen((event) {
      _user = event;
      notifyListeners();
    });
  }

  User? get user => _user;
  bool get isAuthenticated => _user != null;

  Future<void> login(String email, String password) async {
    await _firebaseService.login(email, password);
  }

  Future<void> signup(String email, String password) async {
    await _firebaseService.signup(email, password);
  }

  Future<void> logout() async {
    await _firebaseService.logout();
  }
}
