import 'package:fake_store/features/home/state/cart_bloc.dart';
import 'package:fake_store/features/home/state/cart_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItemWidget extends StatelessWidget {
  final int productId;
  final String title;
  final double price;
  final String imageUrl;
  final double rating;
  final int quantity;
  final String category;
  final int reviewCount;

  const CartItemWidget({
    super.key,

    required this.productId,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.quantity,
    required this.category,
    required this.reviewCount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              // padding: const EdgeInsets.all(8.0),
              child: Image.network(imageUrl),
              height: 80,
              width: 80,
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.length > 20 ? title.substring(0, 20) : title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(category),
                Text(
                  " \$ $price",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            // Rating + delete
            // Rating alineado arriba
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.orange, size: 16),
                    SizedBox(width: 4),
                    Text("$rating"),
                  ],
                ),
                Text("($reviewCount) reseñas"),
              ],
            ),

            const SizedBox(width: 10),

            Container(
              child: GestureDetector(
                onTap: () {
                  context.read<CartBloc>().add(
                    RemoveProductFromCart(productId),
                  );
                },
                child: Icon(Icons.delete_outline, color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
