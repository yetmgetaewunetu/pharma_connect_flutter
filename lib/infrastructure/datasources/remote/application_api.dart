import 'package:dio/dio.dart';

class ApplicationApi {
  final Dio client;
  final String baseUrl;

  ApplicationApi({required this.client, this.baseUrl = '/applications'});

  Future<void> updateApplicationStatus(String id, String status) async {
    await client.patch('$baseUrl/$id/status', data: {'status': status});
  }
}
