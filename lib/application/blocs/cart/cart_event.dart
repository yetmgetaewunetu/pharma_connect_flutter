part of 'cart_bloc.dart';

@freezed
class CartEvent with _$CartEvent {
  const factory CartEvent.loadCart() = _LoadCart;
  const factory CartEvent.addItem(CartItem item) = _AddItem;
  const factory CartEvent.removeItem(String itemId) = _RemoveItem;
  const factory CartEvent.updateQuantity(String itemId, int quantity) = _UpdateQuantity;
  const factory CartEvent.clearCart() = _ClearCart;
  const factory CartEvent.checkout() = _Checkout;
} 