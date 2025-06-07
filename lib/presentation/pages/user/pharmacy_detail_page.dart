import 'package:flutter/material.dart';

class PharmacyDetailPage extends StatelessWidget {
  const PharmacyDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('dagims pharmacy'), // Placeholder title
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'dagims pharmacy', // Placeholder pharmacy name
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildDetailRow('Owner Name:', 'stshsgs'), // Placeholder
            _buildDetailRow(
                'License Number:', '1818191991919191'), // Placeholder
            _buildDetailRow('Email:', 'dagimabate123@gmail.com'), // Placeholder
            _buildDetailRow('Contact Number:', '8446484'), // Placeholder
            _buildDetailRow('Address:', 'shsvs'), // Placeholder
            _buildDetailRow('City:', 'sgsgss'), // Placeholder
            _buildDetailRow('State:', 'svsgs'), // Placeholder
            const SizedBox(height: 24),
            const Text(
              'Location on Map',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // TODO: Implement map view or link
            Container(
              height: 200,
              color: Colors.grey[300], // Placeholder for map area
              child: Center(child: Text('Map Placeholder')),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
