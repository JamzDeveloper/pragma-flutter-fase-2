import 'package:fake_store/features/home/models/cart_item.dart';
import 'package:fake_store/features/home/state/cart/cart_bloc.dart';
import 'package:fake_store/features/home/state/cart/cart_event.dart';
import 'package:fake_store/features/home/widgets/recommended_products.dart';
import 'package:flutter/material.dart';
import 'package:fake_store_client/fake_store_client.dart'; // o tu modelo local
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;
  final List<ProductModel> allProducts;

  const ProductDetailScreen({
    super.key,
    required this.product,
    required this.allProducts,
  });

  @override
  Widget build(BuildContext context) {
    final List<ProductModel> recommendedProducts =
        allProducts
            .where((p) => p.category == product.category && p.id != product.id)
            .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(product.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                product.image,
                height: 250,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              product.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${product.price}",
                  style: const TextStyle(fontSize: 18, color: Colors.green),
                ),
                GestureDetector(
                  onTap: () {
                    final item = CartItem(
                      productId: product.id,
                      title: product.title,
                      price: product.price,
                      imageUrl: product.image,
                      rating: product.rating.rate,
                      reviewCount: product.rating.count,
                      category: product.category,
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
            const SizedBox(height: 8),
            Text("Categoría: ${product.category}"),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.orange, size: 20),
                Text(
                  "${product.rating.rate} (${product.rating.count} reseñas)",
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              "Descripción",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(product.description),
            if (recommendedProducts.isNotEmpty)
              buildRecommendedProducts(context, recommendedProducts),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

Widget buildRecommendedProducts(
  BuildContext context,
  List<ProductModel> products,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          'Productos Recomendados',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(
        height: 180,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return RecommendedProductCart(
              product: product,
              allProducts: products,
            );
          },
        ),
      ),
    ],
  );
}
