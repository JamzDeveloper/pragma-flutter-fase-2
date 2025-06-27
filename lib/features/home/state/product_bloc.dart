import 'package:fake_store/features/home/data/product_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductService productService;

  ProductBloc(this.productService) : super(ProductInitial()) {
    on<LoadProducts>((event, emit) async {
      emit(ProductLoading());
      final result = await productService.fetchProducts();
      result.fold(
        (failure) => emit(ProductError(failure.message)),
        (products) => emit(ProductLoaded(products)),
      );
    });
    on<SearchProducts>((event, emit) {
      final currentState = state;
      if (currentState is ProductLoaded) {
        final filtered =
            currentState.products
                .where(
                  (p) =>
                      p.title.toLowerCase().contains(event.query.toLowerCase()),
                )
                .toList();

        emit(ProductLoaded(currentState.products, filtered));
      }
    });
  }
}
