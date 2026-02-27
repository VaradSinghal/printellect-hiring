import 'package:flutter/material.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';
import '../services/firebase_service.dart';

class CartProvider with ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();
  List<CartItem> _items = [];
  String? _userId;

  void setUserId(String? userId) {
    if (_userId == userId) return;
    _userId = userId;
    if (_userId != null) {
      _firebaseService.getCartItems(_userId!).listen((items) {
        _items = items;
        notifyListeners();
      });
    } else {
      _items = [];
      notifyListeners();
    }
  }

  List<CartItem> get items => _items;

  double get totalAmount {
    return _items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }

  int get itemCount {
    return _items.fold(0, (sum, item) => sum + item.quantity);
  }

  Future<void> addToCart(Product product) async {
    if (_userId == null) return;
    await _firebaseService.addToCart(_userId!, product);
  }

  Future<void> removeFromCart(String cartItemId) async {
    if (_userId == null) return;
    await _firebaseService.removeFromCart(_userId!, cartItemId);
  }
}
