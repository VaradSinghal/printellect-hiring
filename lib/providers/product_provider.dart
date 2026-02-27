import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/firebase_service.dart';

class ProductProvider with ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();
  List<Product> _products = [];
  String _searchQuery = '';
  String _selectedCategory = 'All';
  String _sortBy = 'None';

  ProductProvider() {
    _firebaseService.getProducts().listen((products) {
      _products = products;
      notifyListeners();
    });
  }

  List<Product> get products {
    List<Product> filtered = _products;

    if (_searchQuery.isNotEmpty) {
      filtered = filtered
          .where((p) => p.title.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }

    if (_selectedCategory != 'All') {
      filtered = filtered.where((p) => p.category == _selectedCategory).toList();
    }

    if (_sortBy == 'Price: Low to High') {
      filtered.sort((a, b) => a.price.compareTo(b.price));
    } else if (_sortBy == 'Price: High to Low') {
      filtered.sort((a, b) => b.price.compareTo(a.price));
    } else if (_sortBy == 'Rating') {
      filtered.sort((a, b) => b.rating.compareTo(a.rating));
    }

    return filtered;
  }

  List<String> get categories {
    final cats = _products.map((p) => p.category).toSet().toList();
    cats.sort();
    return ['All', ...cats];
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setSortBy(String sortBy) {
    _sortBy = sortBy;
    notifyListeners();
  }

  String get selectedCategory => _selectedCategory;
  String get sortBy => _sortBy;
}
