import 'package:flutter/material.dart';
import 'package:pharma_connect_flutter/domain/entities/medicine/medicine.dart';

class MedicineDetailsScreen extends StatelessWidget {
  const MedicineDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final medicine = ModalRoute.of(context)!.settings.arguments as Medicine;

    return Scaffold(
      appBar: AppBar(
        title: Text(medicine.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (medicine.image != null)
              Center(
                child: Image.network(
                  medicine.image,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      width: double.infinity,
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.image_not_supported,
                        size: 50,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            const SizedBox(height: 24),
            Text(
              medicine.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            const SizedBox(height: 16),
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              medicine.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            const Text(
              'Category',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Chip(
              label: Text(medicine.category),
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
            ),
            const SizedBox(height: 16),
            const Text(
              'Stock',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement add to cart functionality
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Added to cart'),
                    ),
                  );
                },
                child: const Text('Add to Cart'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
