import 'package:fake_store/features/home/models/cart_item.dart';
import 'package:fake_store/features/home/state/cart/cart_bloc.dart';
import 'package:fake_store/features/home/state/cart/cart_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double price;
  final double rating;
  final int productId;
  final String category;
  final int reviewCount;
  const ProductCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.productId,
    required this.reviewCount,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width / 2) - 24, // no -30
      child: Card(
        elevation: 4,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 145,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return SizedBox(
                        height: 150,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(Icons.star, color: Colors.amber, size: 16),
                  Text(rating.toStringAsFixed(1)),
                ],
              ),
             
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$$price",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      final item = CartItem(
                        productId: productId,
                        title: title,
                        price: price,
                        imageUrl: imageUrl,
                        rating: rating,
                        reviewCount: reviewCount,
                        category: category,
                      );
                      context.read<CartBloc>().add(AddProductToCart(item));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Producto agregado al carrito")),
                      );
                    },
                    child: const Icon(
                      Icons.add_box,
                      color: Colors.orange,
                      size: 25,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
