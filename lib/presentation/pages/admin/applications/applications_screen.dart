import 'package:flutter/material.dart';
import 'package:pharma_connect_flutter/infrastructure/repositories/application_repository_impl.dart';
import 'package:pharma_connect_flutter/infrastructure/datasources/remote/application_api.dart';
import 'package:dio/dio.dart';

class Application {
  final String id;
  final String name;
  final String owner;
  final String contact;
  final String email;
  final String status;

  Application({
    required this.id,
    required this.name,
    required this.owner,
    required this.contact,
    required this.email,
    required this.status,
  });

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      id: json['_id'] as String,
      name: json['pharmacyName'] as String,
      owner: json['ownerName'] as String,
      contact: json['contactNumber'] as String,
      email: json['email'] as String,
      status: json['status'] as String,
    );
  }
}

class AdminApplicationsScreen extends StatefulWidget {
  const AdminApplicationsScreen({Key? key}) : super(key: key);

  @override
  State<AdminApplicationsScreen> createState() =>
      _AdminApplicationsScreenState();
}

class _AdminApplicationsScreenState extends State<AdminApplicationsScreen> {
  int? _selectedIndex;
  List<Application> applications = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    fetchApplications();
  }

  Future<void> fetchApplications() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final dio = Dio(BaseOptions(baseUrl: 'http://localhost:5000/api/v1'));
      final response = await dio.get('/applications');
      final data = response.data['applications'] as List;
      setState(() {
        applications = data.map((json) => Application.fromJson(json)).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load applications';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Applications'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!))
              : Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 16.0),
                  child: ListView.separated(
                    itemCount: applications.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final app = applications[index];
                      final isSelected = _selectedIndex == index;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIndex = isSelected ? null : index;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blueGrey[50],
                            borderRadius: BorderRadius.circular(16),
                            border: isSelected
                                ? Border.all(color: Colors.blue, width: 2)
                                : null,
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                app.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22),
                              ),
                              const SizedBox(height: 8),
                              Text('Owner: ${app.owner}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500)),
                              Text('Contact: ${app.contact}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500)),
                              Text('Email: ${app.email}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500)),
                              Text('Status: ${app.status}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500)),
                              if (isSelected && app.status == 'Pending') ...[
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    OutlinedButton.icon(
                                      onPressed: () async {
                                        final dio = Dio(BaseOptions(
                                            baseUrl:
                                                'http://localhost:5000/api/v1'));
                                        final repo = ApplicationRepositoryImpl(
                                            ApplicationApi(client: dio));
                                        final result = await repo
                                            .rejectApplication(app.id);
                                        result.fold(
                                          (failure) =>
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                            SnackBar(
                                                content: Text(failure.message)),
                                          ),
                                          (_) {
                                            setState(() {
                                              applications[index] = Application(
                                                id: app.id,
                                                name: app.name,
                                                owner: app.owner,
                                                contact: app.contact,
                                                email: app.email,
                                                status: 'Rejected',
                                              );
                                              _selectedIndex = null;
                                            });
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      'Application rejected.')),
                                            );
                                          },
                                        );
                                      },
                                      icon: const Icon(Icons.close,
                                          color: Colors.red),
                                      label: const Text('Reject',
                                          style: TextStyle(color: Colors.red)),
                                      style: OutlinedButton.styleFrom(
                                        side:
                                            const BorderSide(color: Colors.red),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    ElevatedButton.icon(
                                      onPressed: () async {
                                        final dio = Dio(BaseOptions(
                                            baseUrl:
                                                'http://localhost:5000/api/v1'));
                                        final repo = ApplicationRepositoryImpl(
                                            ApplicationApi(client: dio));
                                        final result = await repo
                                            .approveApplication(app.id);
                                        result.fold(
                                          (failure) =>
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                            SnackBar(
                                                content: Text(failure.message)),
                                          ),
                                          (_) {
                                            setState(() {
                                              applications[index] = Application(
                                                id: app.id,
                                                name: app.name,
                                                owner: app.owner,
                                                contact: app.contact,
                                                email: app.email,
                                                status: 'Approved',
                                              );
                                              _selectedIndex = null;
                                            });
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      'Application approved!')),
                                            );
                                          },
                                        );
                                      },
                                      icon: const Icon(Icons.check,
                                          color: Colors.white),
                                      label: const Text('Approve'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ]
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
