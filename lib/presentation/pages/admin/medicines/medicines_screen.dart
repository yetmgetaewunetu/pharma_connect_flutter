import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharma_connect_flutter/application/blocs/admin/medicine/medicine_cubit.dart';
import 'package:pharma_connect_flutter/domain/entities/medicine/medicine.dart';

class AdminMedicinesScreen extends StatelessWidget {
  AdminMedicinesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicines Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _refreshMedicines(context),
          ),
        ],
      ),
      body: BlocConsumer<MedicineCubit, MedicineState>(
        listener: (context, state) {
          if (state is MedicineError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
          if (state is MedicineLoaded && _showDeleteSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Medicine deleted successfully!')),
            );
            _showDeleteSuccess = false;
          }
        },
        builder: (context, state) {
          if (state is MedicineLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is MedicineLoaded) {
            return _buildMedicineList(context, state.medicines);
          }

          return _buildInitialState();
        },
      ),
    );
  }

  Widget _buildInitialState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.medication, size: 64),
          SizedBox(height: 16),
          Text('No medicines data available'),
        ],
      ),
    );
  }

  Widget _buildMedicineList(BuildContext context, List<Medicine> medicines) {
    if (medicines.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64),
            SizedBox(height: 16),
            Text('No medicines found'),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => _refreshMedicines(context),
      child: ListView.builder(
        itemCount: medicines.length,
        itemBuilder: (context, index) =>
            _buildMedicineItem(context, medicines[index]),
      ),
    );
  }

  Widget _buildMedicineItem(BuildContext context, Medicine medicine) {
    return Builder(
      builder: (itemContext) => Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: ListTile(
          leading: medicine.image.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    medicine.image,
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(Icons.medication),
                  ),
                )
              : const Icon(Icons.medication, size: 48),
          title: Text(
            medicine.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Category: ${medicine.category}'),
              if (medicine.description.isNotEmpty)
                Text(
                  medicine.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
          trailing: PopupMenuButton<String>(
            onSelected: (value) =>
                _handleMedicineAction(itemContext, value, medicine),
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'edit', child: Text('Edit')),
              PopupMenuItem(value: 'delete', child: Text('Delete')),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _refreshMedicines(BuildContext context) async {
    context.read<MedicineCubit>().fetchMedicines();
  }

  void _handleMedicineAction(
      BuildContext context, String action, Medicine medicine) async {
    switch (action) {
      case 'edit':
        final result = await Navigator.pushNamed(
          context,
          '/medicine/edit',
          arguments: medicine,
        );
        if (result != null) {
          // If edit was successful, refresh the medicines list
          _refreshMedicines(context);
        }
        break;
      case 'delete':
        _showDeleteConfirmation(context, medicine);
        break;
    }
  }

  void _showAddMedicineDialog(BuildContext context) {
    // TODO: Implement add medicine dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Medicine'),
        content: const Text('Add medicine form will go here'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Save medicine
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showEditMedicineDialog(BuildContext context, Medicine medicine) {
    // TODO: Implement edit medicine dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Medicine'),
        content: const Text('Edit medicine form will go here'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Update medicine
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  bool _showDeleteSuccess = false;

  void _showDeleteConfirmation(BuildContext context, Medicine medicine) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Medicine'),
        content: Text('Are you sure you want to delete ${medicine.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _showDeleteSuccess = true;
              context.read<MedicineCubit>().deleteMedicine(medicine.id);
              Navigator.pop(context);
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
