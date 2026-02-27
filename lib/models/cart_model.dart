class CartItem {
  final String id;
  final String productId;
  final String title;
  final double price;
  final String image;
  int quantity;

  CartItem({
    required this.id,
    required this.productId,
    required this.title,
    required this.price,
    required this.image,
    this.quantity = 1,
  });

  factory CartItem.fromFirestore(String id, Map<String, dynamic> data) {
    return CartItem(
      id: id,
      productId: data['productId'] ?? '',
      title: data['title'] ?? '',
      price: (data['price'] ?? 0.0).toDouble(),
      image: data['image'] ?? '',
      quantity: data['quantity'] ?? 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'title': title,
      'price': price,
      'image': image,
      'quantity': quantity,
    };
  }
}
