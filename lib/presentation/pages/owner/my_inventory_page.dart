import 'package:flutter/material.dart';
import 'package:pharma_connect_flutter/domain/entities/inventory/inventory_item.dart';
import 'package:pharma_connect_flutter/domain/repositories/inventory_repository.dart';
import 'package:pharma_connect_flutter/infrastructure/datasources/local/session_manager.dart';
import 'package:pharma_connect_flutter/infrastructure/datasources/remote/inventory_api.dart';
import 'package:pharma_connect_flutter/infrastructure/repositories/inventory_repository_impl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:pharma_connect_flutter/presentation/pages/owner/edit_inventory_item_screen.dart';

class MyInventoryPage extends StatefulWidget {
  const MyInventoryPage({Key? key}) : super(key: key);

  @override
  State<MyInventoryPage> createState() => _MyInventoryPageState();
}

class _MyInventoryPageState extends State<MyInventoryPage> {
  late final InventoryRepository _inventoryRepository;
  late final SessionManager _sessionManager;
  List<InventoryItem> _inventoryItems = [];
  List<InventoryItem> _filteredItems = [];
  bool _isLoading = true;
  String? _error;
  String _searchQuery = '';

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
    setState(() {
      _isLoading = true;
      _error = null;
    });
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
        _filteredItems = _applySearch(_searchQuery, inventory);
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

  List<InventoryItem> _applySearch(String query, List<InventoryItem> items) {
    if (query.isEmpty) return items;
    final lower = query.toLowerCase();
    return items
        .where((item) => item.medicineName.toLowerCase().contains(lower))
        .toList();
  }

  void _onSearchChanged(String value) {
    setState(() {
      _searchQuery = value;
      _filteredItems = _applySearch(value, _inventoryItems);
    });
  }

  Future<void> _onDeleteItem(InventoryItem item) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Item'),
        content: Text('Are you sure you want to delete ${item.medicineName}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      try {
        final pharmacyId = _sessionManager.getPharmacyId();
        if (pharmacyId != null) {
          await _inventoryRepository.deleteInventoryItem(pharmacyId, item.id);
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

  void _onEditItem(InventoryItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditInventoryItemScreen(item: item),
      ),
    ).then((result) {
      if (result == true) {
        _loadInventory();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Inventory'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadInventory,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search medicines in inventory',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: _onSearchChanged,
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _error != null
                    ? Center(
                        child: Text(_error!,
                            style: const TextStyle(color: Colors.red)),
                      )
                    : _filteredItems.isEmpty
                        ? const Center(
                            child: Text('No inventory items available'))
                        : RefreshIndicator(
                            onRefresh: _loadInventory,
                            child: ListView.builder(
                              padding: const EdgeInsets.all(16),
                              itemCount: _filteredItems.length,
                              itemBuilder: (context, index) {
                                final item = _filteredItems[index];
                                return Card(
                                  elevation: 4,
                                  margin: const EdgeInsets.only(bottom: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                if (item.category != null &&
                                                    item.category!.isNotEmpty)
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 8),
                                                    child: Chip(
                                                      label:
                                                          Text(item.category!),
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .primaryColor
                                                              .withOpacity(0.1),
                                                    ),
                                                  ),
                                                Text(
                                                  item.medicineName,
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            PopupMenuButton<String>(
                                              onSelected: (value) {
                                                if (value == 'edit') {
                                                  _onEditItem(item);
                                                } else if (value == 'delete') {
                                                  _onDeleteItem(item);
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
                                        if (item.price > 0)
                                          Row(
                                            children: [
                                              const Icon(Icons.attach_money,
                                                  size: 16),
                                              const SizedBox(width: 4),
                                              Text(
                                                'Price: \\${item.price.toStringAsFixed(2)}',
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
                                            const Icon(Icons.inventory_2,
                                                size: 16),
                                            const SizedBox(width: 4),
                                            Text(
                                              'Quantity: \\${item.quantity}',
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
                                            const Icon(Icons.calendar_today,
                                                size: 16),
                                            const SizedBox(width: 4),
                                            Text(
                                              'Expiry Date: \\${DateFormat('MMM dd, yyyy').format(item.expiryDate)}',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
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
          ),
        ],
      ),
    );
  }
}
