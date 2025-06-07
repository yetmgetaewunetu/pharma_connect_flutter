import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Saved Medicines'),
        actions: [
          TextButton(
            onPressed: () {
              // TODO: Implement remove all logic
            },
            child:
                const Text('Remove All', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: 1, // Placeholder count
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    // Placeholder for image
                    Container(
                      width: 80,
                      height: 80,
                      color: Colors.grey[300],
                      margin: const EdgeInsets.only(right: 16),
                      // TODO: Add actual image
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Paracetamol',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)), // Placeholder
                          const SizedBox(height: 4),
                          const Text('dagims pharmacy',
                              style:
                                  TextStyle(color: Colors.grey)), // Placeholder
                          const SizedBox(height: 8),
                          const Text('Price: Br 12.00',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold)), // Placeholder
                          const SizedBox(height: 4),
                          const Text('Quantity: 12',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold)), // Placeholder
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete,
                          color: Colors.red), // Delete icon
                      onPressed: () {
                        // TODO: Implement remove item logic
                      },
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
