import 'package:dartz/dartz.dart';
import 'package:pharma_connect_flutter/core/errors/failures.dart';
import 'package:pharma_connect_flutter/domain/entities/order/order.dart' as domain;

abstract class OrderRepository {
  Future<Either<Failure, List<domain.Order>>> getOrders();
  Future<Either<Failure, domain.Order>> getOrderById(String id);
  Future<Either<Failure, domain.Order>> createOrder(domain.Order order);
  Future<Either<Failure, domain.Order>> updateOrder(domain.Order order);
  Future<Either<Failure, Unit>> deleteOrder(String id);
} 