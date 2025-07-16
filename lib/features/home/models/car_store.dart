
import 'package:fake_store/features/home/models/cart_item.dart';

class CartState {
  final List<CartItem> items;

  CartState({required this.items});

double get subtotal =>
    double.parse(items.fold(0.0, (sum, item) => sum + item.total).toStringAsFixed(2));

  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);
}


