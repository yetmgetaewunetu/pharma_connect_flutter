import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharma_connect_flutter/application/blocs/medicine/add_medicine_bloc.dart';
import 'package:pharma_connect_flutter/domain/entities/medicine/medicine.dart';
import 'package:pharma_connect_flutter/presentation/widgets/loading_indicator.dart';
import 'package:pharma_connect_flutter/presentation/widgets/error_dialog.dart';

class AddMedicineScreen extends StatelessWidget {
  const AddMedicineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Medicine to Platform'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Medicine Name *',
                  prefixIcon: Icon(Icons.medication),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Category *',
                  prefixIcon: Icon(Icons.category),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Description *',
                  prefixIcon: Icon(Icons.description),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Image URL *',
                  prefixIcon: Icon(Icons.link),
                  hintText: 'Provide a publicly accessible URL.',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement add medicine logic
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('ADD MEDICINE'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddMedicineForm extends StatefulWidget {
  const AddMedicineForm({Key? key}) : super(key: key);

  @override
  State<AddMedicineForm> createState() => _AddMedicineFormState();
}

class _AddMedicineFormState extends State<AddMedicineForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  final _manufacturerController = TextEditingController();
  final _categoryController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _manufacturerController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final medicine = Medicine(
          id: '', // Will be assigned by the server
          name: _nameController.text,
          description: _descriptionController.text,
          category: _categoryController.text,
          image: "");

      context.read<AddMedicineBloc>().add(AddMedicineEvent.submitted(medicine));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter a name' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter a description' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter a price' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _stockController,
              decoration: const InputDecoration(labelText: 'Stock Quantity'),
              keyboardType: TextInputType.number,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter stock quantity' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _manufacturerController,
              decoration: const InputDecoration(labelText: 'Manufacturer'),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter a manufacturer' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _categoryController,
              decoration: const InputDecoration(labelText: 'Category'),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter a category' : null,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Add Medicine'),
            ),
          ],
        ),
      ),
    );
  }
}
