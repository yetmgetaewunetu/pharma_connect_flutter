import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class JoinUsPage extends StatefulWidget {
  const JoinUsPage({Key? key}) : super(key: key);

  @override
  State<JoinUsPage> createState() => _JoinUsPageState();
}

class _JoinUsPageState extends State<JoinUsPage> {
  final _formKey = GlobalKey<FormState>();
  final _pharmacyNameController = TextEditingController();
  final _ownerNameController = TextEditingController();
  final _contactNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final _licenseNumberController = TextEditingController();
  final _licenseImageUrlController = TextEditingController();
  final _pharmacyImageUrlController = TextEditingController();
  final _googleMapsLinkController = TextEditingController();

  bool _isLoading = false;
  String? _error;
  String? _success;

  @override
  void dispose() {
    _pharmacyNameController.dispose();
    _ownerNameController.dispose();
    _contactNumberController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipCodeController.dispose();
    _licenseNumberController.dispose();
    _licenseImageUrlController.dispose();
    _pharmacyImageUrlController.dispose();
    _googleMapsLinkController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isLoading = true;
      _error = null;
      _success = null;
    });
    try {
      final dio = Dio(BaseOptions(baseUrl: 'http://10.4.113.71:5000/api/v1'));
      final payload = {
        "ownerName": _ownerNameController.text.trim(),
        "pharmacyName": _pharmacyNameController.text.trim(),
        "contactNumber": _contactNumberController.text.trim(),
        "email": _emailController.text.trim(),
        "address": _addressController.text.trim(),
        "city": _cityController.text.trim(),
        "state": _stateController.text.trim(),
        "zipCode": _zipCodeController.text.trim(),
        "latitude": 0.0, // TODO: parse from Google Maps link if needed
        "longitude": 0.0, // TODO: parse from Google Maps link if needed
        "licenseNumber": _licenseNumberController.text.trim(),
        "licenseImage": _licenseImageUrlController.text.trim(),
        "pharmacyImage": _pharmacyImageUrlController.text.trim(),
        "ownerId":
            "demo-owner-id", // TODO: replace with real ownerId if available
        "googleMapsLink": _googleMapsLinkController.text.trim(),
      };
      final response =
          await dio.post('/applications/createApplication', data: payload);
      if (response.data['success'] == true) {
        setState(() {
          _success = 'Application submitted successfully!';
        });
      } else {
        setState(() {
          _error = response.data['message'] ?? 'Submission failed.';
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Network or server error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join Us As A Pharmacy'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_error != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child:
                      Text(_error!, style: const TextStyle(color: Colors.red)),
                ),
              if (_success != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(_success!,
                      style: const TextStyle(color: Colors.green)),
                ),
              const Text(
                'To join our Pharmacy Partner Program, simply fill out the form below...',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _pharmacyNameController,
                decoration: const InputDecoration(
                  labelText: 'Pharmacy Name *',
                ),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _ownerNameController,
                decoration: const InputDecoration(
                  labelText: 'Owner Name *',
                ),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _contactNumberController,
                decoration: const InputDecoration(
                  labelText: 'Contact Number *',
                ),
                keyboardType: TextInputType.phone,
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email *',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Address (Street/Subcity) *',
                ),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(
                  labelText: 'City *',
                ),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _stateController,
                decoration: const InputDecoration(
                  labelText: 'State/Region *',
                ),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _zipCodeController,
                decoration: const InputDecoration(
                  labelText: 'Zip Code *',
                ),
                keyboardType: TextInputType.number,
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _licenseNumberController,
                decoration: const InputDecoration(
                  labelText: 'License Number *',
                ),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 24),
              const Text(
                'Image Uploads',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _licenseImageUrlController,
                decoration: const InputDecoration(
                  labelText: 'License Image URL *',
                  hintText: 'Paste the URL of your license image',
                ),
                keyboardType: TextInputType.url,
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _pharmacyImageUrlController,
                decoration: const InputDecoration(
                  labelText: 'Pharmacy Image URL *',
                  hintText: 'Paste the URL of your pharmacy image',
                ),
                keyboardType: TextInputType.url,
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 24),
              const Text(
                'Pharmacy Location Link',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _googleMapsLinkController,
                decoration: const InputDecoration(
                  labelText: 'Google Maps Link *',
                  hintText:
                      'Find your pharmacy on Google Maps, click Share -> Copy link, and paste here.',
                ),
                keyboardType: TextInputType.url,
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 24.0),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        )
                      : const Text('Submit Application'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
