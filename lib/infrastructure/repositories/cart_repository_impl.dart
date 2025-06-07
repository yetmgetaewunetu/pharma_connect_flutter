import 'package:dartz/dartz.dart';
import 'package:pharma_connect_flutter/core/errors/failures.dart';
import 'package:pharma_connect_flutter/domain/entities/cart/cart_item.dart';
import 'package:pharma_connect_flutter/domain/repositories/cart_repository.dart';
import 'package:pharma_connect_flutter/infrastructure/datasources/cart_api.dart';

class CartRepositoryImpl implements CartRepository {
  final CartApi api;

  CartRepositoryImpl(this.api);

  @override
  Future<Either<Failure, List<CartItem>>> getCartItems() async {
    try {
      final items = await api.getCartItems();
      return Right(items);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CartItem>>> addItem(CartItem item) async {
    try {
      final items = await api.addItem(item);
      return Right(items);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CartItem>>> removeItem(String itemId) async {
    try {
      final items = await api.removeItem(itemId);
      return Right(items);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CartItem>>> updateQuantity(String itemId, int quantity) async {
    try {
      final items = await api.updateQuantity(itemId, quantity);
      return Right(items);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CartItem>>> clearCart() async {
    try {
      final items = await api.clearCart();
      return Right(items);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CartItem>>> checkout() async {
    try {
      final items = await api.checkout();
      return Right(items);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
