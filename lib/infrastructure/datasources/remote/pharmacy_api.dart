import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pharma_connect_flutter/domain/entities/pharmacy/pharmacy.dart';
import 'package:pharma_connect_flutter/core/constants.dart';

class PharmacyApi {
  final String baseUrl = '${Constants.apiBaseUrl}/pharmacies';
  final http.Client client;

  PharmacyApi({required this.client});

  Future<Pharmacy> getPharmacy(String id) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/$id'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      print('Get Pharmacy Response Status: ${response.statusCode}');
      print('Get Pharmacy Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final dynamic decodedResponse = json.decode(response.body);
        print('Decoded Response Type: ${decodedResponse.runtimeType}');

        if (decodedResponse is Map) {
          if (decodedResponse.containsKey('success') &&
              decodedResponse['success'] == true) {
            if (decodedResponse.containsKey('data')) {
              return Pharmacy.fromJson(
                  Map<String, dynamic>.from(decodedResponse['data']));
            }
          }
          throw Exception(
              'Invalid response format: Missing success or data field');
        } else {
          throw Exception('Invalid response format: Expected a map');
        }
      } else {
        throw Exception('Failed to load pharmacy: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in getPharmacy: $e');
      throw Exception('Error: $e');
    }
  }

  Future<Pharmacy> updatePharmacy(String id, Map<String, dynamic> data) async {
    try {
      final response = await client.patch(
        Uri.parse('$baseUrl/$id'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        final dynamic decodedResponse = json.decode(response.body);
        if (decodedResponse is Map &&
            decodedResponse.containsKey('success') &&
            decodedResponse['success'] == true &&
            decodedResponse.containsKey('data')) {
          return Pharmacy.fromJson(
              Map<String, dynamic>.from(decodedResponse['data']));
        }
        throw Exception(
            'Invalid response format: Missing success or data field');
      } else {
        throw Exception('Failed to update pharmacy: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> deletePharmacy(String id) async {
    try {
      final response = await client.delete(
        Uri.parse('$baseUrl/$id'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete pharmacy: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Pharmacy>> getPharmacies() async {
    try {
      final response = await client.get(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final dynamic decodedResponse = json.decode(response.body);
        if (decodedResponse is Map &&
            decodedResponse.containsKey('success') &&
            decodedResponse['success'] == true &&
            decodedResponse.containsKey('data')) {
          final List<dynamic> data = decodedResponse['data'];
          return data
              .map((json) => Pharmacy.fromJson(Map<String, dynamic>.from(json)))
              .toList();
        }
        throw Exception(
            'Invalid response format: Missing success or data field');
      } else {
        throw Exception('Failed to load pharmacies: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
