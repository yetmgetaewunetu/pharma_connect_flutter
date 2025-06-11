import 'package:flutter/material.dart';
import 'package:pharma_connect_flutter/domain/entities/inventory/inventory_item.dart';
import 'package:pharma_connect_flutter/infrastructure/datasources/local/session_manager.dart';
import 'package:pharma_connect_flutter/infrastructure/datasources/remote/inventory_api.dart';
import 'package:pharma_connect_flutter/infrastructure/repositories/inventory_repository_impl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class EditInventoryItemScreen extends StatefulWidget {
  final InventoryItem item;
  const EditInventoryItemScreen({Key? key, required this.item})
      : super(key: key);

  @override
  State<EditInventoryItemScreen> createState() =>
      _EditInventoryItemScreenState();
}

class _EditInventoryItemScreenState extends State<EditInventoryItemScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _quantityController;
  late TextEditingController _priceController;
  late TextEditingController _expiryDateController;
  late TextEditingController _categoryController;
  DateTime? _selectedExpiryDate;
  bool _isSubmitting = false;
  String? _error;
  late SessionManager _sessionManager;
  String? _pharmacyId;
  String? _token;

  @override
  void initState() {
    super.initState();
    _quantityController =
        TextEditingController(text: widget.item.quantity.toString());
    _priceController =
        TextEditingController(text: widget.item.price.toStringAsFixed(2));
    _expiryDateController = TextEditingController(
        text: DateFormat('yyyy-MM-dd').format(widget.item.expiryDate));
    _categoryController =
        TextEditingController(text: widget.item.category ?? '');
    _selectedExpiryDate = widget.item.expiryDate;
    _initializeSession();
  }

  Future<void> _initializeSession() async {
    final prefs = await SharedPreferences.getInstance();
    _sessionManager = SessionManager(prefs);
    setState(() {
      _pharmacyId = _sessionManager.getPharmacyId();
      _token = _sessionManager.getToken();
    });
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _priceController.dispose();
    _expiryDateController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  Future<void> _pickExpiryDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedExpiryDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedExpiryDate = pickedDate;
        _expiryDateController.text =
            DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate() ||
        _pharmacyId == null ||
        _token == null) {
      setState(() {
        _error = 'Please fill all fields and make sure you are logged in.';
      });
      return;
    }
    setState(() {
      _isSubmitting = true;
      _error = null;
    });
    try {
      final repo = InventoryRepositoryImpl(
        inventoryApi: InventoryApi(
          client: http.Client(),
          token: _token!,
        ),
      );
      final userId = _sessionManager.getUserId();
      final data = {
        'quantity': int.parse(_quantityController.text),
        'price': double.parse(_priceController.text),
        'expiryDate': _selectedExpiryDate!.toIso8601String(),
        'category': _categoryController.text,
        'updatedBy': userId,
        'medicineId': widget.item.medicineId,
        'medicineName': widget.item.medicineName,
        'pharmacy': _pharmacyId,
      };
      print('Updating inventory item: ' + data.toString());
      print(
          'PharmacyId: [32m[1m[4m$_pharmacyId[0m, InventoryId: [32m[1m[4m${widget.item.id}[0m');
      await repo.updateInventoryItem(_pharmacyId!, widget.item.id, data);
      if (mounted) {
        setState(() {
          _isSubmitting = false;
          _error = null;
        });
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      setState(() {
        _isSubmitting = false;
        final errorMsg = e.toString();
        if (errorMsg
            .contains("type 'Null' is not a subtype of type 'String'")) {
          _error = 'An unexpected error occurred. Please try again.';
        } else {
          _error = errorMsg;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Inventory Item')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Medicine: ${widget.item.medicineName}',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              TextFormField(
                controller: _quantityController,
                decoration: const InputDecoration(labelText: 'Quantity *'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter quantity' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price *'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter price' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _expiryDateController,
                decoration: const InputDecoration(
                  labelText: 'Expiry Date *',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () => _pickExpiryDate(context),
                validator: (value) => value == null || value.isEmpty
                    ? 'Select expiry date'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(labelText: 'Category'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isSubmitting ? null : _submitForm,
                child: _isSubmitting
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
