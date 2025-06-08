import 'package:pharma_connect_flutter/domain/entities/pharmacy/pharmacy.dart';
import 'package:pharma_connect_flutter/domain/repositories/pharmacy_repository.dart';
import 'package:pharma_connect_flutter/infrastructure/datasources/remote/pharmacy_api.dart';

class PharmacyRepositoryImpl implements PharmacyRepository {
  final PharmacyApi pharmacyApi;

  PharmacyRepositoryImpl({required this.pharmacyApi});

  @override
  Future<Pharmacy> getPharmacy(String id) async {
    return await pharmacyApi.getPharmacy(id);
  }

  @override
  Future<Pharmacy> updatePharmacy(String id, Map<String, dynamic> data) async {
    return await pharmacyApi.updatePharmacy(id, data);
  }

  @override
  Future<void> deletePharmacy(String id) async {
    await pharmacyApi.deletePharmacy(id);
  }

  @override
  Future<List<Pharmacy>> getPharmacies() async {
    return await pharmacyApi.getPharmacies();
  }
}
