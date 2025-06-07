import 'package:dio/dio.dart';
import 'package:pharma_connect_flutter/domain/entities/medicine/medicine.dart';

class MedicineApi {
  final Dio client;
  final String baseUrl;

  MedicineApi({
    required this.client,
    this.baseUrl = '/medicines',
  });

  Future<Response> getMedicines() async {
    return await client.get(baseUrl);
  }

  Future<Response> getMedicineById(String id) async {
    return await client.get('$baseUrl/$id');
  }

  Future<Response> addMedicine(Medicine medicine) async {
    return await client.post(baseUrl, data: medicine.toJson());
  }

  Future<Response> updateMedicine(Medicine medicine) async {
    return await client.put('$baseUrl/${medicine.id}', data: medicine.toJson());
  }

  Future<Response> deleteMedicine(String id) async {
    return await client.delete('$baseUrl/$id');
  }

  Future<Response> searchMedicines(String query) async {
    return await client.get('$baseUrl/search', queryParameters: {'q': query});
  }

  Future<Response> getMedicinesByCategory(String category) async {
    return await client.get('$baseUrl/category/$category');
  }
}
