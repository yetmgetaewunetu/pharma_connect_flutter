import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharma_connect_flutter/application/blocs/admin/pharmacy/pharmacy_cubit.dart';
import 'package:pharma_connect_flutter/domain/entities/pharmacy/pharmacy.dart';

class AdminPharmaciesScreen extends StatefulWidget {
  const AdminPharmaciesScreen({Key? key}) : super(key: key);

  @override
  State<AdminPharmaciesScreen> createState() => _AdminPharmaciesScreenState();
}

class _AdminPharmaciesScreenState extends State<AdminPharmaciesScreen> {
  String _search = '';
  final _searchController = TextEditingController();
  late final PharmacyCubit _pharmacyCubit;

  @override
  void initState() {
    super.initState();
    _pharmacyCubit = context.read<PharmacyCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadPharmacies());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadPharmacies() {
    _pharmacyCubit.fetchPharmacies();
  }

  List<Pharmacy> _filterPharmacies(List<Pharmacy> pharmacies) {
    if (_search.isEmpty) return pharmacies;

    final query = _search.toLowerCase();
    return pharmacies.where((pharmacy) {
      return pharmacy.name.toLowerCase().contains(query) ||
          (pharmacy.city.toLowerCase().contains(query) ?? false) ||
          pharmacy.address.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pharmacies Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadPharmacies,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search Pharmacies',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: _search.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _search = '');
                        },
                      )
                    : null,
              ),
              onChanged: (value) => setState(() => _search = value),
            ),
          ),
          Expanded(
            child: BlocConsumer<PharmacyCubit, PharmacyState>(
              listener: (context, state) {
                if (state is PharmacyError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                if (state is PharmacyLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is PharmacyLoaded) {
                  final filteredPharmacies =
                      _filterPharmacies(state.pharmacies);

                  if (filteredPharmacies.isEmpty) {
                    return _buildEmptyState();
                  }

                  return _buildPharmacyList(filteredPharmacies);
                }

                return _buildInitialState();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.search_off,
            size: 64,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            _search.isEmpty
                ? 'No pharmacies found'
                : 'No pharmacies match your search',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPharmacyList(List<Pharmacy> pharmacies) {
    return RefreshIndicator(
      onRefresh: () async => _loadPharmacies(),
      child: ListView.builder(
        itemCount: pharmacies.length,
        itemBuilder: (context, index) {
          final pharmacy = pharmacies[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              title: Text(
                pharmacy.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(pharmacy.address),
                  Text('City: ${pharmacy.city}'),
                ],
              ),
              trailing: PopupMenuButton<String>(
                onSelected: (value) => _handlePopupSelection(value, pharmacy),
                itemBuilder: (context) => const [
                  PopupMenuItem(
                    value: 'delete',
                    child: Text('Delete'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInitialState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.local_pharmacy, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No pharmacies data available',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  void _handlePopupSelection(String value, Pharmacy pharmacy) {
    if (value == 'delete') {
      _showDeleteConfirmation(pharmacy);
    }
  }

  void _showDeleteConfirmation(Pharmacy pharmacy) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Pharmacy'),
        content: Text('Are you sure you want to delete ${pharmacy.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _pharmacyCubit.deletePharmacy(pharmacy.id);
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
