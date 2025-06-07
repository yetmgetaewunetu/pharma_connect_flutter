import 'package:pharma_connect_flutter/domain/entities/medicine/medicine.dart';
import 'package:pharma_connect_flutter/infrastructure/datasources/api_client.dart';

class MedicineApi {
  final ApiClient _client;
  static const String _baseUrl = '/medicines';

  MedicineApi(this._client);

  Future<List<Medicine>> getAll() async {
    final response = await _client.dio.get(_baseUrl);
    final List data = response.data['data'];
    return data.map((json) => Medicine.fromJson(json)).toList();
  }

  Future<Medicine> add(Medicine medicine) async {
    final response = await _client.dio.post(_baseUrl, data: medicine.toJson());
    return Medicine.fromJson(response.data['data']);
  }

  Future<Medicine> update(String id, Medicine medicine) async {
    final response =
        await _client.dio.put('$_baseUrl/$id', data: medicine.toJson());
    return Medicine.fromJson(response.data['data']);
  }

  Future<void> delete(String id) async {
    await _client.dio.delete('$_baseUrl/$id');
  }
}
