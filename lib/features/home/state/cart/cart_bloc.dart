import 'package:fake_store/features/home/models/cart_item.dart';
import 'package:fake_store/features/home/state/cart/cart_event.dart';
import 'package:fake_store/features/home/state/cart/cart_state.dart';
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
          reviewCount: existingItem.reviewCount,
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

    on<AddQuantityToProduct>((event, emit) {
      final updatedCart = _updateQuantity(event.productId, increase: true);
      emit(state.copyWith(items: updatedCart));
    });

    on<SubtractQuantityFromProduct>((event, emit) {
      final updatedCart = _updateQuantity(event.productId, increase: false);
      emit(state.copyWith(items: updatedCart));
    });


    on<ClearCart>((event, emit) {
      emit(state.copyWith(items: []));
    });
  }
  List<CartItem> _updateQuantity(int productId, {required bool increase}) {
    return state.items.map((item) {
      if (item.productId == productId) {
        final updatedQuantity =
            increase ? item.quantity + 1 : item.quantity - 1;
        return item.copyWith(quantity: updatedQuantity.clamp(1, 100));
      }
      return item;
    }).toList();
  }
}
