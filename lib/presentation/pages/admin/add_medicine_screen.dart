import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharma_connect_flutter/application/blocs/medicine/add_medicine_bloc.dart';
import 'package:pharma_connect_flutter/domain/entities/medicine/medicine.dart';
import 'package:pharma_connect_flutter/presentation/widgets/loading_indicator.dart';
import 'package:pharma_connect_flutter/presentation/widgets/error_dialog.dart';
import 'package:dio/dio.dart';
import 'package:pharma_connect_flutter/infrastructure/repositories/medicine_repository_impl.dart';
import 'package:pharma_connect_flutter/infrastructure/datasources/remote/medicine_api.dart';

class AddMedicineScreen extends StatelessWidget {
  const AddMedicineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dio = Dio(BaseOptions(baseUrl: 'http://localhost:5000/api/v1'));
    return BlocProvider(
      create: (context) => AddMedicineBloc(
        MedicineRepositoryImpl(
          MedicineApi(client: dio, baseUrl: '/medicines'),
        ),
      ),
      child: BlocListener<AddMedicineBloc, AddMedicineState>(
        listener: (context, state) {
          state.when(
            initial: () {},
            loading: () {},
            success: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Medicine added successfully!')),
              );
            },
            error: (message) {
              showDialog(
                context: context,
                builder: (context) => ErrorDialog(message: message),
              );
            },
          );
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Add Medicine to Platform'),
          ),
          body: BlocBuilder<AddMedicineBloc, AddMedicineState>(
            builder: (context, state) {
              return state.when(
                initial: () => const AddMedicineForm(),
                loading: () => const Center(child: LoadingIndicator()),
                success: () => const AddMedicineForm(),
                error: (message) => const AddMedicineForm(),
              );
            },
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
  final _categoryController = TextEditingController();
  final _imageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final medicine = Medicine(
        id: '', // Will be assigned by the server
        name: _nameController.text,
        description: _descriptionController.text,
        category: _categoryController.text,
        image: _imageController.text,
      );
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
              decoration: const InputDecoration(labelText: 'Medicine Name *'),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter a name' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _categoryController,
              decoration: const InputDecoration(labelText: 'Category *'),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter a category' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description *'),
              maxLines: 3,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter a description' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _imageController,
              decoration: const InputDecoration(
                labelText: 'Image URL *',
                hintText: 'Provide a publicly accessible URL.',
              ),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter an image URL' : null,
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
