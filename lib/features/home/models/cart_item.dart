class CartItem {
  final int productId;
  final String title;
  final double price;
  final String imageUrl;
  final String category;
  final double rating;
  final int reviewCount;
  int quantity;

  CartItem({
    required this.productId,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.category,
    this.quantity = 1,
  });

  double get total => double.parse((price * quantity).toStringAsFixed(2));

  CartItem copyWith({
    int? productId,
    String? title,
    double? price,
    String? imageUrl,
    String? category,
    double? rating,
    int? reviewCount,
    int? quantity,
  }) {
    return CartItem(
      productId: productId ?? this.productId,
      title: title ?? this.title,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
    );
  }
}
