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

  double get total => price * quantity;
}
