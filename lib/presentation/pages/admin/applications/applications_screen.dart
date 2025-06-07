import 'package:flutter/material.dart';

class Application {
  final String name;
  final String owner;
  final String contact;
  final String email;
  final String status;

  Application({
    required this.name,
    required this.owner,
    required this.contact,
    required this.email,
    required this.status,
  });
}

class AdminApplicationsScreen extends StatefulWidget {
  const AdminApplicationsScreen({Key? key}) : super(key: key);

  @override
  State<AdminApplicationsScreen> createState() =>
      _AdminApplicationsScreenState();
}

class _AdminApplicationsScreenState extends State<AdminApplicationsScreen> {
  int? _selectedIndex;

  // Example data; replace with real data from your backend/bloc
  List<Application> get applications => [
        Application(
            name: 'fhs',
            owner: 'gshs',
            contact: '9794',
            email: 'dagi2@gmail.com',
            status: 'Approved'),
        Application(
            name: 'gshs',
            owner: 'bsns',
            contact: '#4494',
            email: 'g@gmail.com',
            status: 'Approved'),
        Application(
            name: 'gssh',
            owner: 'djd',
            contact: '9795',
            email: 's@gmail.com',
            status: 'Approved'),
        Application(
            name: 'kydt8d',
            owner: 'i5d58d',
            contact: '35357238',
            email: 'neba1456@gmail.com',
            status: 'Pending'),
        Application(
            name: 'dagim',
            owner: 'dagim',
            contact: '45481926',
            email: 'da@gmail.com',
            status: 'Approved'),
        Application(
            name: 'sjsjw',
            owner: 'gwhw',
            contact: '1213',
            email: 'tsige@gmail.com',
            status: 'Approved'),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Applications'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        child: ListView.separated(
          itemCount: applications.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
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
                        style: const TextStyle(fontWeight: FontWeight.w500)),
                    Text('Contact: ${app.contact}',
                        style: const TextStyle(fontWeight: FontWeight.w500)),
                    Text('Email: ${app.email}',
                        style: const TextStyle(fontWeight: FontWeight.w500)),
                    Text('Status: ${app.status}',
                        style: const TextStyle(fontWeight: FontWeight.w500)),
                    if (isSelected && app.status == 'Pending') ...[
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          OutlinedButton.icon(
                            onPressed: () {
                              // TODO: Implement reject logic
                            },
                            icon: const Icon(Icons.close, color: Colors.red),
                            label: const Text('Reject',
                                style: TextStyle(color: Colors.red)),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.red),
                            ),
                          ),
                          const SizedBox(width: 16),
                          ElevatedButton.icon(
                            onPressed: () {
                              // TODO: Implement approve logic
                            },
                            icon: const Icon(Icons.check, color: Colors.white),
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
