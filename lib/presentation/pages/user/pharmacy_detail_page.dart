import 'package:flutter/material.dart';
import 'package:pharma_connect_flutter/domain/entities/pharmacy/pharmacy.dart';
import 'package:pharma_connect_flutter/infrastructure/datasources/remote/pharmacy_api.dart';
import 'package:pharma_connect_flutter/infrastructure/repositories/pharmacy_repository_impl.dart';
import 'package:http/http.dart' as http;

class PharmacyDetailPage extends StatelessWidget {
  final String pharmacyId;
  const PharmacyDetailPage({Key? key, required this.pharmacyId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pharmacyRepository = PharmacyRepositoryImpl(
      pharmacyApi: PharmacyApi(client: http.Client()),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pharmacy Details'),
      ),
      body: FutureBuilder<Pharmacy>(
        future: pharmacyRepository.getPharmacy(pharmacyId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: \\${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data found.'));
          }
          final pharmacy = snapshot.data!;
          return SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                Text(pharmacy.name,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
                _buildDetailRow('Owner Name:', pharmacy.ownerName),
                _buildDetailRow('License Number:', pharmacy.licenseNumber),
                _buildDetailRow('Email:', pharmacy.email),
                _buildDetailRow('Contact Number:', pharmacy.contactNumber),
                _buildDetailRow('Address:', pharmacy.address),
                _buildDetailRow('City:', pharmacy.city),
                _buildDetailRow('State:', pharmacy.state),
                if (pharmacy.pharmacyImage != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Image.network(pharmacy.pharmacyImage!),
            ),
          ],
        ),
          );
        },
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
