
import 'package:fake_store/features/home/models/cart_item.dart';

class CartState {
  final List<CartItem> items;

  CartState({required this.items});

  double get subtotal => items.fold(0, (sum, item) => sum + item.total);

  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);
}


