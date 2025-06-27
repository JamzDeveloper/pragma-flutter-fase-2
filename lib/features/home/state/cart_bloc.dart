import 'package:fake_store/features/home/models/cart_item.dart';
import 'package:fake_store/features/home/state/cart_event.dart';
import 'package:fake_store/features/home/state/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState(items: [])) {
    on<AddProductToCart>((event, emit) {
      final existingIndex = state.items.indexWhere(
        (item) => item.productId == event.item.productId,
      );

      final updatedItems = List<CartItem>.from(state.items);

      if (existingIndex != -1) {
        final existingItem = updatedItems[existingIndex];
        updatedItems[existingIndex] = CartItem(
          productId: existingItem.productId,
          title: existingItem.title,
          price: existingItem.price,
          imageUrl: existingItem.imageUrl,
          rating: existingItem.rating,
          quantity: existingItem.quantity + 1,
          category: existingItem.category,
          reviewCount: existingItem.reviewCount
        );
      } else {
        updatedItems.add(event.item);
      }

      emit(state.copyWith(items: updatedItems));
    });

    on<RemoveProductFromCart>((event, emit) {
      final updatedItems =
          state.items
              .where((item) => item.productId != event.productId)
              .toList();
      emit(state.copyWith(items: updatedItems));
    });

    on<ClearCart>((event, emit) {
      emit(state.copyWith(items: []));
    });
  }
}
