import 'package:flutter/material.dart';
import 'package:pharma_connect_flutter/domain/entities/inventory/inventory_item.dart';
import 'package:pharma_connect_flutter/domain/repositories/inventory_repository.dart';
import 'package:pharma_connect_flutter/infrastructure/datasources/local/session_manager.dart';
import 'package:pharma_connect_flutter/infrastructure/datasources/remote/inventory_api.dart';
import 'package:pharma_connect_flutter/infrastructure/repositories/inventory_repository_impl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class MyInventoryPage extends StatefulWidget {
  const MyInventoryPage({Key? key}) : super(key: key);

  @override
  State<MyInventoryPage> createState() => _MyInventoryPageState();
}

class _MyInventoryPageState extends State<MyInventoryPage> {
  late final InventoryRepository _inventoryRepository;
  late final SessionManager _sessionManager;
  List<InventoryItem> _inventoryItems = [];
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

    final token = _sessionManager.getToken();
    print(
        'MyInventoryPage: Token retrieved from SessionManager: $token'); // Debug log

    if (token == null) {
      setState(() {
        _error = 'No authentication token found. Please log in again.';
        _isLoading = false;
      });
      return;
    }

    _inventoryRepository = InventoryRepositoryImpl(
      inventoryApi: InventoryApi(
        client: http.Client(),
        token: token,
      ),
    );
    _loadInventory();
  }

  Future<void> _loadInventory() async {
    try {
      final pharmacyId = _sessionManager.getPharmacyId();
      print(
          'MyInventoryPage: Pharmacy ID retrieved from SessionManager: $pharmacyId'); // Debug log

      if (pharmacyId == null) {
        setState(() {
          _error = 'Please complete your pharmacy profile first.';
          _isLoading = false;
        });
        return;
      }
      print(
          'MyInventoryPage: Fetching inventory for pharmacy ID: $pharmacyId'); // Debug log
      final inventory = await _inventoryRepository.getInventory(pharmacyId);
      setState(() {
        _inventoryItems = inventory;
        _isLoading = false;
      });
    } catch (e) {
      print('MyInventoryPage: Error loading inventory: $e');
      String errorMessage;
      if (e.toString().contains('503')) {
        errorMessage =
            'The server is temporarily unavailable. Please try again later.';
      } else if (e.toString().contains('401')) {
        errorMessage = 'Your session has expired. Please log in again.';
      } else if (e.toString().contains('404')) {
        errorMessage = 'No inventory found for your pharmacy.';
      } else {
        errorMessage =
            'An error occurred while loading inventory. Please try again.';
      }
      setState(() {
        _error = errorMessage;
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
            Icon(
              _error!.contains('temporarily unavailable')
                  ? Icons.cloud_off
                  : Icons.error_outline,
              size: 48,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                _error!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadInventory,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_inventoryItems.isEmpty) {
      return const Center(
        child: Text('No inventory items available'),
      );
    }

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _loadInventory,
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _inventoryItems.length,
          itemBuilder: (context, index) {
            final item = _inventoryItems[index];
            return Card(
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item.medicineName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        PopupMenuButton<String>(
                          onSelected: (value) async {
                            if (value == 'edit') {
                              // TODO: Implement edit functionality
                            } else if (value == 'delete') {
                              final confirmed = await showDialog<bool>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Delete Item'),
                                  content: const Text(
                                      'Are you sure you want to delete this item?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, false),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, true),
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                ),
                              );

                              if (confirmed == true) {
                                try {
                                  final pharmacyId =
                                      _sessionManager.getPharmacyId();
                                  if (pharmacyId != null) {
                                    await _inventoryRepository
                                        .deleteInventoryItem(
                                            pharmacyId, item.id);
                                    _loadInventory();
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Error: $e'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              }
                            }
                          },
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: 'edit',
                              child: Text('Edit'),
                            ),
                            const PopupMenuItem(
                              value: 'delete',
                              child: Text('Delete'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.attach_money, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          'Price: \$${item.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.inventory_2, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          'Quantity: ${item.quantity}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          'Expiry Date: ${DateFormat('MMM dd, yyyy').format(item.expiryDate)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.info, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          'Status: ${item.status}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: item.status == 'active'
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
