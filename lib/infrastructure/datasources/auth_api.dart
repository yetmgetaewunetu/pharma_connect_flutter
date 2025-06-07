import 'package:dio/dio.dart';
import 'package:pharma_connect_flutter/domain/entities/auth/user.dart';
import 'package:pharma_connect_flutter/infrastructure/datasources/api_client.dart';

class AuthApi {
  final ApiClient _client;
  static const String _baseUrl = 'https://pharma-connect-backend-8cay.onrender.com/api/v1';
  

  AuthApi(this._client);

  Future<User> login(String email, String password) async {
    try {
      final response = await _client.dio.post(
        '$_baseUrl/users/signIn',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.data['success'] == true) {
        final userData = response.data['data'];
        // Create a basic user from login response
        final user = User(
          id: userData['userId'],
          email: email,
          name: '', // We'll get the full name from profile
          role: userData['role'],
        );
        final token = response.headers.value('authorization');
        if (token != null) {
          _client.setAuthToken(token);
        }
        return user;
      } else {
        throw Exception(response.data['message'] ?? 'Login failed');
      }
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<User> register(String email, String password, String name) async {
    try {
      final response = await _client.dio.post(
        '$_baseUrl/users/signUp',
        data: {
          'email': email,
          'password': password,
          'name': name,
        },
      );

      if (response.data['success'] == true) {
        final userData = response.data['data'];
        final user = User(
          id: userData['userId'],
          email: email,
          name: name,
          role: userData['role'] ?? 'user',
        );
        final token = response.headers.value('authorization');
        if (token != null) {
          _client.setAuthToken(token);
        }
        return user;
      } else {
        throw Exception(response.data['message'] ?? 'Registration failed');
      }
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _client.dio.post('$_baseUrl/users/signOut');
      _client.clearAuthToken();
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<User> getCurrentUser() async {
    try {
      final response = await _client.dio.get('$_baseUrl/users/profile');

      if (response.data['success'] == true) {
        final userData = response.data['data'];
        return User(
          id: userData['userId'],
          email: userData['email'],
          name: userData['name'],
          role: userData['role'],
          phone: userData['phone'],
          address: userData['address'],
        );
      } else {
        throw Exception(response.data['message'] ?? 'Failed to get user profile');
      }
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<void> updateProfile(User user) async {
    try {
      final response = await _client.dio.put(
        '$_baseUrl/users/profile',
        data: {
          'name': user.name,
          'phone': user.phone,
          'address': user.address,
        },
      );

      if (response.data['success'] != true) {
        throw Exception(response.data['message'] ?? 'Failed to update profile');
      }
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<void> changePassword(String currentPassword, String newPassword) async {
    try {
      final response = await _client.dio.put(
        '$_baseUrl/users/password',
        data: {
          'currentPassword': currentPassword,
          'newPassword': newPassword,
        },
      );

      if (response.data['success'] != true) {
        throw Exception(response.data['message'] ?? 'Failed to change password');
      }
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  void _handleError(DioException e) {
    if (e.response?.statusCode == 401) {
      _client.clearAuthToken();
    }
    throw Exception(e.response?.data['message'] ?? e.message);
  }
} 