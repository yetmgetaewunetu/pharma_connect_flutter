import 'package:dio/dio.dart';
import 'package:pharma_connect_flutter/domain/entities/order/order.dart';
import 'package:pharma_connect_flutter/infrastructure/datasources/api_client.dart';

class OrderApi {
  final ApiClient _client;

  OrderApi(this._client);

  Future<List<Order>> getOrders() async {
    try {
      final response = await _client.dio.get('/orders');
      return (response.data as List)
          .map((json) => Order.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Order> getOrderById(String id) async {
    try {
      final response = await _client.dio.get('/orders/$id');
      return Order.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Order> createOrder(Order order) async {
    try {
      final response = await _client.dio.post(
        '/orders',
        data: order.toJson(),
      );
      return Order.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Order> updateOrder(Order order) async {
    try {
      final response = await _client.dio.put(
        '/orders/${order.id}',
        data: order.toJson(),
      );
      return Order.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> deleteOrder(String id) async {
    try {
      await _client.dio.delete('/orders/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    if (e.response?.statusCode == 404) {
      return Exception('Order not found');
    }
    if (e.response?.statusCode == 400) {
      return Exception('Invalid request: ${e.response?.data['message']}');
    }
    if (e.response?.statusCode == 401) {
      return Exception('Unauthorized: Please login again');
    }
    return Exception('Failed to perform operation: ${e.message}');
  }
} 