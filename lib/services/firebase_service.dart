import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product_model.dart';
import '../models/cart_model.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance; 
  Stream<User?> get user => _auth.authStateChanges();

  Future<UserCredential?> signup(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print('Signup error: $e');
      rethrow;
    }
  }

  Future<UserCredential?> login(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print('Login error: $e');
      rethrow;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<void> uploadInitialDataOnce() async {
    final prefs = await SharedPreferences.getInstance();
    final bool alreadyUploaded = prefs.getBool('data_uploaded') ?? false;

    if (alreadyUploaded) return;

    try {
      final String response = await rootBundle.loadString('assets/sample.json');
      final List<dynamic> data = json.decode(response);

      final batch = _db.batch();
      for (var productJson in data) {
        final product = Product.fromJson(productJson);
        final docRef = _db.collection('products').doc(product.id);
        batch.set(docRef, product.toMap());
      }
      await batch.commit();
      await prefs.setBool('data_uploaded', true);
      print('Data uploaded successfully');
    } catch (e) {
      print('Error uploading data: $e');
      if (e.toString().contains('permission-denied')) {
        print('IMPORTANT: Please update your Firestore Security Rules to allow writes to the "products" collection.');
      }
    }
  }

  Stream<List<Product>> getProducts() {
    return _db
        .collection('products')
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Product.fromFirestore(doc)).toList(),
        );
  }

  Stream<List<CartItem>> getCartItems(String userId) {
    return _db
        .collection('users')
        .doc(userId)
        .collection('cart')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => CartItem.fromFirestore(doc.id, doc.data()))
              .toList(),
        );
  }

  Future<void> addToCart(String userId, Product product) async {
    final cartRef = _db.collection('users').doc(userId).collection('cart');
    final doc = await cartRef.doc(product.id).get();

    if (doc.exists) {
      await cartRef.doc(product.id).update({
        'quantity': FieldValue.increment(1),
      });
    } else {
      final cartItem = CartItem(
        id: product.id,
        productId: product.id,
        title: product.title,
        price: product.price,
        image: product.image,
      );
      await cartRef.doc(product.id).set(cartItem.toMap());
    }
  }

  Future<void> removeFromCart(String userId, String cartItemId) async {
    await _db
        .collection('users')
        .doc(userId)
        .collection('cart')
        .doc(cartItemId)
        .delete();
  }
}
