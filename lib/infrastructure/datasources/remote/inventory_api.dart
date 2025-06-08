import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pharma_connect_flutter/core/constants.dart';
import 'package:pharma_connect_flutter/domain/entities/inventory/inventory_item.dart';

class InventoryApi {
  final String baseUrl = '${Constants.apiBaseUrl}/pharmacies';
  final http.Client client;
  final String token;

  InventoryApi({required this.client, required this.token});

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

  Future<InventoryItem> addInventoryItem(
      String pharmacyId, Map<String, dynamic> data) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/$pharmacyId/inventory'),
        headers: _headers,
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        return InventoryItem.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to add inventory item');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<InventoryItem>> getInventory(String pharmacyId) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/$pharmacyId/inventory'),
        headers: _headers,
      );

      print('Get Inventory Response Status: ${response.statusCode}');
      print('Get Inventory Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final dynamic decodedResponse = json.decode(response.body);
        print('Decoded Response Type: ${decodedResponse.runtimeType}');

        if (decodedResponse is Map) {
          // If the response is a map, check if it contains a data field
          if (decodedResponse.containsKey('data') &&
              decodedResponse['data'] is List) {
            final List<dynamic> data = decodedResponse['data'];
            return data.map((json) => InventoryItem.fromJson(json)).toList();
          } else {
            throw Exception(
                'Invalid response format: Expected a list of items or a map with a data field containing a list');
          }
        } else if (decodedResponse is List) {
          return decodedResponse
              .map((json) => InventoryItem.fromJson(json))
              .toList();
        } else {
          throw Exception(
              'Invalid response format: Expected a list or a map with a data field');
        }
      } else {
        throw Exception('Failed to load inventory: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in getInventory: $e');
      throw Exception('Error: $e');
    }
  }

  Future<InventoryItem> getInventoryItem(
      String pharmacyId, String inventoryId) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/$pharmacyId/inventory/$inventoryId'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        return InventoryItem.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load inventory item');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<InventoryItem> updateInventoryItem(
      String pharmacyId, String inventoryId, Map<String, dynamic> data) async {
    try {
      final response = await client.patch(
        Uri.parse('$baseUrl/$pharmacyId/inventory/$inventoryId'),
        headers: _headers,
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        return InventoryItem.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to update inventory item');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> deleteInventoryItem(
      String pharmacyId, String inventoryId) async {
    try {
      final response = await client.delete(
        Uri.parse('$baseUrl/$pharmacyId/inventory/$inventoryId'),
        headers: _headers,
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete inventory item');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
