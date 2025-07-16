import 'package:fake_store/features/home/screens/process_payment.dart';
import 'package:fake_store/features/home/widgets/cart_item.dart';
import 'package:fake_store/core/theme/colors.dart';
import 'package:fake_store/features/home/state/cart/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fake_store/features/home/state/cart/cart_state.dart';

class CartTab extends StatelessWidget {
  const CartTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final cartItems = state.items;
        final subTotal = double.parse(
          cartItems
              .fold(0.0, (sum, item) => sum + item.total)
              .toStringAsFixed(2),
        );
        return Column(
          children: [
            cartItems.isEmpty
                ? (Expanded(child: Center(child: Text("No hay elemento"))))
                : Expanded(
                  child: ListView.separated(
                    itemCount: cartItems.length,
                    itemBuilder:
                        (context, item) => CartItemWidget(
                          category: cartItems[item].category,
                          imageUrl: cartItems[item].imageUrl,
                          price: cartItems[item].price,
                          productId: cartItems[item].productId,
                          quantity: cartItems[item].quantity,
                          rating: cartItems[item].rating,
                          reviewCount: cartItems[item].reviewCount,
                          title: cartItems[item].title,
                        ),
                    separatorBuilder: (context, index) => SizedBox(height: 12),
                  ),
                ),

            const Divider(height: 10),

            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Text(
                        "SubTotal",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "\$ ${subTotal}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const PaymentProcessingScreen(),
                        ),
                      );
                    },
                    child: Text("Pagar", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
