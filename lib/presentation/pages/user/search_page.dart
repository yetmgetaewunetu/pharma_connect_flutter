import 'package:flutter/material.dart';
import 'package:pharma_connect_flutter/presentation/pages/user/pharmacy_detail_page.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search for Medicine',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
            onSubmitted: (query) {
              // TODO: Implement search logic and display results
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Price',
                    border: OutlineInputBorder(),
                  ),
                  items:
                      ['All', 'Low to High', 'High to Low'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    // TODO: Implement price filter logic
                  },
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Location',
                    border: OutlineInputBorder(),
                  ),
                  items: ['All', 'Nearby', 'Specific Location']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    // TODO: Implement location filter logic
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Results for: ', // Placeholder, will be dynamic based on search query
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          // TODO: Implement Search Results List based on image 2
          Expanded(
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
                              const Text('dagims pharmacy',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)), // Placeholder
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.location_on,
                                      size: 16, color: Colors.grey),
                                  SizedBox(width: 4),
                                  Text('shsvs',
                                      style: TextStyle(
                                          color: Colors.grey)), // Placeholder
                                ],
                              ),
                              const SizedBox(height: 4),
                              const Text('15.1 km',
                                  style: TextStyle(
                                      color: Colors.grey)), // Placeholder
                              const SizedBox(height: 8),
                              const Text('Br 12.00',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.green)), // Placeholder
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            TextButton(
                              onPressed: () {
                                // TODO: Navigate to Pharmacy Detail Page
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            const PharmacyDetailPage()));
                              },
                              child: const Text('See pharmacy detail'),
                            ),
                            IconButton(
                              icon: const Icon(
                                  Icons.add_shopping_cart), // Or similar icon
                              onPressed: () {
                                // TODO: Implement add to cart logic
                              },
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
        ],
      ),
    );
  }
}
