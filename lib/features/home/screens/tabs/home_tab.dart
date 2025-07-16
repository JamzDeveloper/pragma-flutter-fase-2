import 'package:fake_store/core/theme/colors.dart';
import 'package:fake_store/features/home/screens/porduct_detailts.dart';
import 'package:fake_store/features/home/state/products/product_bloc.dart';
import 'package:fake_store/features/home/state/products/product_event.dart';
import 'package:fake_store/features/home/state/products/product_state.dart';
import 'package:fake_store/features/home/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        searchWidget(context),

        Expanded(
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is ProductError) {
                return Center(child: Text("❌ Error ${state.message}"));
              }
              if (state is ProductLoaded) {
                final products = state.filteredProducts;

                return RefreshIndicator(
                  color: AppColors.primaryBlue,
                  onRefresh: () async {
                    context.read<ProductBloc>().add(LoadProducts());
                  },
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.75,
                        ),
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => ProductDetailScreen(product: product,allProducts: products,),
                            ),
                          );
                        },
                        child: ProductCard(
                          title: product.title,
                          imageUrl: product.image,
                          price: product.price,
                          rating: product.rating.rate,
                          productId: product.id,
                          category: product.category,
                          reviewCount: product.rating.count,
                        ),
                      );
                    },
                  ),
                );
              }
              return SizedBox();
            },
          ),
        ),
      ],
    );
  }

  Padding searchWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),

      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: "Buscar productos....",
          prefixIcon: Icon(Icons.search),
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (value) {
          context.read<ProductBloc>().add(SearchProducts(value));
        },
      ),
    );
  }
}
