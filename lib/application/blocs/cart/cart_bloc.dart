import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharma_connect_flutter/domain/entities/cart/cart_item.dart';
import 'package:pharma_connect_flutter/domain/repositories/cart_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';
part 'cart_bloc.freezed.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository repository;

  CartBloc(this.repository) : super(const CartState.initial()) {
    on<CartEvent>((event, emit) async {
      await event.map(
        loadCart: (e) => _onLoadCart(e, emit),
        addItem: (e) => _onAddItem(e, emit),
        removeItem: (e) => _onRemoveItem(e, emit),
        updateQuantity: (e) => _onUpdateQuantity(e, emit),
        clearCart: (e) => _onClearCart(e, emit),
        checkout: (e) => _onCheckout(e, emit),
      );
    });
  }

  Future<void> _onLoadCart(_LoadCart event, Emitter<CartState> emit) async {
    emit(const CartState.loading());
    final result = await repository.getCartItems();
    result.fold(
      (failure) => emit(CartState.error(failure.message)),
      (items) => emit(CartState.loaded(items)),
    );
  }

  Future<void> _onAddItem(_AddItem event, Emitter<CartState> emit) async {
    final result = await repository.addItem(event.item);
    result.fold(
      (failure) => emit(CartState.error(failure.message)),
      (items) => emit(CartState.loaded(items)),
    );
  }

  Future<void> _onRemoveItem(_RemoveItem event, Emitter<CartState> emit) async {
    final result = await repository.removeItem(event.itemId);
    result.fold(
      (failure) => emit(CartState.error(failure.message)),
      (items) => emit(CartState.loaded(items)),
    );
  }

  Future<void> _onUpdateQuantity(_UpdateQuantity event, Emitter<CartState> emit) async {
    final result = await repository.updateQuantity(event.itemId, event.quantity);
    result.fold(
      (failure) => emit(CartState.error(failure.message)),
      (items) => emit(CartState.loaded(items)),
    );
  }

  Future<void> _onClearCart(_ClearCart event, Emitter<CartState> emit) async {
    final result = await repository.clearCart();
    result.fold(
      (failure) => emit(CartState.error(failure.message)),
      (items) => emit(CartState.loaded(items)),
    );
  }

  Future<void> _onCheckout(_Checkout event, Emitter<CartState> emit) async {
    emit(const CartState.loading());
    final result = await repository.checkout();
    result.fold(
      (failure) => emit(CartState.error(failure.message)),
      (items) => emit(CartState.loaded(items)),
    );
  }
} 