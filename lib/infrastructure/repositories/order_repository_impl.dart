import 'package:dartz/dartz.dart';
import 'package:pharma_connect_flutter/core/errors/failures.dart';
import 'package:pharma_connect_flutter/domain/entities/order/order.dart' as domain;
import 'package:pharma_connect_flutter/domain/repositories/order_repository.dart';
import 'package:pharma_connect_flutter/infrastructure/datasources/order_api.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderApi api;

  OrderRepositoryImpl(this.api);

  @override
  Future<Either<Failure, List<domain.Order>>> getOrders() async {
    try {
      final orders = await api.getOrders();
      return Right(orders);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, domain.Order>> getOrderById(String id) async {
    try {
      final order = await api.getOrderById(id);
      return Right(order);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, domain.Order>> createOrder(domain.Order order) async {
    try {
      final createdOrder = await api.createOrder(order);
      return Right(createdOrder);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, domain.Order>> updateOrder(domain.Order order) async {
    try {
      final updatedOrder = await api.updateOrder(order);
      return Right(updatedOrder);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteOrder(String id) async {
    try {
      await api.deleteOrder(id);
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
} 