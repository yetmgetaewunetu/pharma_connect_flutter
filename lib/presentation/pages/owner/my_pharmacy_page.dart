import 'package:flutter/material.dart';
import 'package:pharma_connect_flutter/domain/entities/pharmacy/pharmacy.dart';
import 'package:pharma_connect_flutter/domain/repositories/pharmacy_repository.dart';
import 'package:pharma_connect_flutter/infrastructure/datasources/local/session_manager.dart';
import 'package:pharma_connect_flutter/infrastructure/datasources/remote/pharmacy_api.dart';
import 'package:pharma_connect_flutter/infrastructure/repositories/pharmacy_repository_impl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MyPharmacyPage extends StatefulWidget {
  const MyPharmacyPage({Key? key}) : super(key: key);

  @override
  State<MyPharmacyPage> createState() => _MyPharmacyPageState();
}

class _MyPharmacyPageState extends State<MyPharmacyPage> {
  late final PharmacyRepository _pharmacyRepository;
  late final SessionManager _sessionManager;
  Pharmacy? _pharmacy;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initializeDependencies();
  }

  Future<void> _initializeDependencies() async {
    final prefs = await SharedPreferences.getInstance();
    _sessionManager = SessionManager(prefs);
    _pharmacyRepository = PharmacyRepositoryImpl(
      pharmacyApi: PharmacyApi(client: http.Client()),
    );
    _loadPharmacy();
  }

  Future<void> _loadPharmacy() async {
    try {
      final pharmacyId = _sessionManager.getPharmacyId();
      if (pharmacyId == null) {
        setState(() {
          _error = 'No pharmacy ID found. Please log in again.';
          _isLoading = false;
        });
        return;
      }

      final pharmacy = await _pharmacyRepository.getPharmacy(pharmacyId);
      setState(() {
        _pharmacy = pharmacy;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Error: $_error',
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadPharmacy,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_pharmacy == null) {
      return const Center(
        child: Text('No pharmacy data available'),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'My Pharmacy',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          // TODO: Implement edit pharmacy details functionality
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _pharmacy!.name,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoCard(
                    context,
                    'Pharmacy Information',
                    [
                      _buildDetailRow('Owner Name', _pharmacy!.ownerName),
                      _buildDetailRow(
                          'License Number', _pharmacy!.licenseNumber),
                      _buildDetailRow('Email', _pharmacy!.email),
                      _buildDetailRow(
                          'Contact Number', _pharmacy!.contactNumber),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildInfoCard(
                    context,
                    'Location Details',
                    [
                      _buildDetailRow('Address', _pharmacy!.address),
                      _buildDetailRow('City', _pharmacy!.city),
                      _buildDetailRow('State', _pharmacy!.state),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.location_on,
                                  color: Theme.of(context).primaryColor),
                              const SizedBox(width: 8),
                              const Text(
                                'Location on Map',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.map,
                                size: 50,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
      BuildContext context, String title, List<Widget> details) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 16),
            ...details,
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
