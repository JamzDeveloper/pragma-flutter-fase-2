import 'package:fake_store/features/home/models/product.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductModel> products;
  final List<ProductModel> filteredProducts;

  ProductLoaded(this.products, [List<ProductModel>? filtered])
    : filteredProducts = filtered ?? products;

    
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}
