import 'package:fake_store/features/home/state/cart/cart_bloc.dart';
import 'package:fake_store/features/home/state/cart/cart_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddSubtractQuantityWidget extends StatelessWidget {
  const AddSubtractQuantityWidget({
    super.key,
    required this.productId,
    required this.quantity,
  });

  final int productId;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.red),
          onPressed: () {
            context.read<CartBloc>().add(RemoveProductFromCart(productId));
          },
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey.shade200,
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  context.read<CartBloc>().add(
                    SubtractQuantityFromProduct(productId),
                  );
                },
              ),
              Text(
                '$quantity',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  context.read<CartBloc>().add(AddQuantityToProduct(productId));
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
