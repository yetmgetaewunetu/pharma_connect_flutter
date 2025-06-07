import 'package:dio/dio.dart';
import 'package:pharma_connect_flutter/domain/entities/cart/cart_item.dart';
import 'package:pharma_connect_flutter/infrastructure/datasources/api_client.dart';

class CartApi {
  final ApiClient _client;

  CartApi(this._client);

  Future<List<CartItem>> getCartItems() async {
    try {
      final response = await _client.dio.get('/cart');
      return (response.data as List)
          .map((json) => CartItem.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<CartItem>> addItem(CartItem item) async {
    try {
      final response = await _client.dio.post(
        '/cart',
        data: item.toJson(),
      );
      return (response.data as List)
          .map((json) => CartItem.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<CartItem>> removeItem(String itemId) async {
    try {
      final response = await _client.dio.delete('/cart/$itemId');
      return (response.data as List)
          .map((json) => CartItem.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<CartItem>> updateQuantity(String itemId, int quantity) async {
    try {
      final response = await _client.dio.put(
        '/cart/$itemId',
        data: {'quantity': quantity},
      );
      return (response.data as List)
          .map((json) => CartItem.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<CartItem>> clearCart() async {
    try {
      final response = await _client.dio.delete('/cart');
      return (response.data as List)
          .map((json) => CartItem.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<CartItem>> checkout() async {
    try {
      final response = await _client.dio.post('/cart/checkout');
      return (response.data as List)
          .map((json) => CartItem.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    if (e.response?.statusCode == 404) {
      return Exception('Cart item not found');
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