import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharma_connect_flutter/application/blocs/medicine/list_medicine_bloc.dart';
import 'package:pharma_connect_flutter/domain/entities/medicine/medicine.dart';
import 'package:pharma_connect_flutter/infrastructure/datasources/local/session_manager.dart';
import 'package:pharma_connect_flutter/infrastructure/datasources/remote/inventory_api.dart';
import 'package:pharma_connect_flutter/infrastructure/repositories/inventory_repository_impl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:pharma_connect_flutter/infrastructure/repositories/medicine_repository_impl.dart';
import 'package:pharma_connect_flutter/infrastructure/datasources/remote/medicine_api.dart';
import 'package:dio/dio.dart';

class AddInventoryMedicinePage extends StatefulWidget {
  const AddInventoryMedicinePage({Key? key}) : super(key: key);

  @override
  State<AddInventoryMedicinePage> createState() =>
      _AddInventoryMedicinePageState();
}

class _AddInventoryMedicinePageState extends State<AddInventoryMedicinePage> {
  final _formKey = GlobalKey<FormState>();
  Medicine? _selectedMedicine;
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  DateTime? _selectedExpiryDate;
  bool _isSubmitting = false;

  late SessionManager _sessionManager;
  String? _pharmacyId;
  String? _token;
  String? _error;

  @override
  void initState() {
    super.initState();
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
    super.dispose();
  }

  InputDecoration _getInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.grey[50],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey[400]!),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
    );
  }

  Future<void> _pickExpiryDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
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
        _selectedMedicine == null ||
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
        'medicineId': _selectedMedicine!.id,
        'medicineName': _selectedMedicine!.name,
        'pharmacy': _pharmacyId!,
        'price': double.parse(_priceController.text),
        'quantity': int.parse(_quantityController.text),
        'expiryDate': _selectedExpiryDate!.toIso8601String(),
        'category': _selectedMedicine!.category,
        'updatedBy': userId,
      };
      await repo.addInventoryItem(_pharmacyId!, data);
      setState(() {
        _isSubmitting = false;
        _error = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Medicine added to inventory!')),
      );
      _formKey.currentState!.reset();
      setState(() {
        _selectedMedicine = null;
        _selectedExpiryDate = null;
        _expiryDateController.clear();
      });
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
      body: BlocProvider(
        create: (context) => ListMedicineBloc(
          MedicineRepositoryImpl(
            MedicineApi(
              client:
                  Dio(BaseOptions(baseUrl: 'http://10.4.113.71:5000/api/v1')),
              baseUrl: '/medicines',
            ),
          ),
        )..add(const ListMedicineEvent.loaded()),
        child: BlocBuilder<ListMedicineBloc, ListMedicineState>(
          builder: (context, state) {
            final medicines = state.maybeWhen(
              loaded: (medicines) => medicines,
              orElse: () => <Medicine>[],
            );
            // Debug prints
            print('Medicines list length: \\${medicines.length}');
            print('Selected medicine: \\${_selectedMedicine?.name}');
            // If not using Freezed for Medicine, ensure == and hashCode are implemented based on id
            final dropdownValue = medicines.contains(_selectedMedicine)
                ? _selectedMedicine
                : null;
            if (medicines.isEmpty) {
              return const Center(child: Text('No medicines available'));
            }
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add Medicine',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Add new medicine to your inventory',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _buildFormField(
                                context,
                                'Medicine Name',
                                DropdownButtonFormField<Medicine>(
                                  decoration:
                                      _getInputDecoration('Select Medicine'),
                                  value: dropdownValue,
                                  items: medicines.map((medicine) {
                                    return DropdownMenuItem<Medicine>(
                                      value: medicine,
                                      child: Text(medicine.name),
                                    );
                                  }).toList(),
                                  onChanged: (medicine) {
                                    setState(() {
                                      _selectedMedicine = medicine;
                                    });
                                  },
                                  validator: (value) => value == null
                                      ? 'Please select a medicine'
                                      : null,
                                ),
                              ),
                              const SizedBox(height: 20),
                              _buildFormField(
                                context,
                                'Quantity',
                                TextFormField(
                                  controller: _quantityController,
                                  decoration:
                                      _getInputDecoration('Enter quantity'),
                                  keyboardType: TextInputType.number,
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                          ? 'Enter quantity'
                                          : null,
                                ),
                              ),
                              const SizedBox(height: 20),
                              _buildFormField(
                                context,
                                'Price',
                                TextFormField(
                                  controller: _priceController,
                                  decoration:
                                      _getInputDecoration('Enter price in Br'),
                                  keyboardType: TextInputType.number,
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                          ? 'Enter price'
                                          : null,
                                ),
                              ),
                              const SizedBox(height: 20),
                              _buildFormField(
                                context,
                                'Expiry Date',
                                TextFormField(
                                  controller: _expiryDateController,
                                  decoration:
                                      _getInputDecoration('Select expiry date')
                                          .copyWith(
                                    suffixIcon: Icon(
                                      Icons.calendar_today,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  readOnly: true,
                                  onTap: () => _pickExpiryDate(context),
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                          ? 'Select expiry date'
                                          : null,
                                ),
                              ),
                              const SizedBox(height: 30),
                              ElevatedButton(
                                onPressed: _isSubmitting ? null : _submitForm,
                                style: ElevatedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                ),
                                child: _isSubmitting
                                    ? const CircularProgressIndicator(
                                        color: Colors.white)
                                    : const Text(
                                        'Add to Inventory',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildFormField(BuildContext context, String label, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}
