import 'package:flutter/material.dart';

class AddInventoryMedicinePage extends StatelessWidget {
  const AddInventoryMedicinePage({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildFormField(
                        context,
                        'Medicine Name',
                        DropdownButtonFormField<String>(
                          decoration: _getInputDecoration('Select Medicine'),
                          items: ['Medicine 1', 'Medicine 2', 'Medicine 3']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            // TODO: Implement medicine selection logic
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildFormField(
                        context,
                        'Quantity',
                        TextField(
                          decoration: _getInputDecoration('Enter quantity'),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildFormField(
                        context,
                        'Price',
                        TextField(
                          decoration: _getInputDecoration('Enter price in Br'),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildFormField(
                        context,
                        'Expiry Date',
                        TextField(
                          decoration: _getInputDecoration('Select expiry date')
                              .copyWith(
                            suffixIcon: Icon(
                              Icons.calendar_today,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          readOnly: true,
                          onTap: () async {
                            // TODO: Implement date picker
                            final pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100),
                            );
                            if (pickedDate != null) {
                              // Update the text field with the selected date
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          // TODO: Implement add to inventory logic
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        child: const Text(
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
        ],
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
