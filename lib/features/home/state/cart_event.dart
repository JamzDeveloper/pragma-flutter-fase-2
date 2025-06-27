import 'package:fake_store/features/home/models/cart_item.dart';

abstract class CartEvent {}

class AddProductToCart extends CartEvent {
  final CartItem item;

  AddProductToCart(this.item);
}

class RemoveProductFromCart extends CartEvent {
  final int productId;

  RemoveProductFromCart(this.productId);
}

class ClearCart extends CartEvent {}
