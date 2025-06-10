import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharma_connect_flutter/presentation/pages/user/pharmacy_detail_page.dart';
import 'package:pharma_connect_flutter/application/blocs/user/search_medicine_cubit.dart';
import 'package:pharma_connect_flutter/infrastructure/repositories/medicine_repository_impl.dart';
import 'package:pharma_connect_flutter/infrastructure/datasources/remote/medicine_api.dart';
import 'package:dio/dio.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchMedicineCubit(
        MedicineRepositoryImpl(
          MedicineApi(
            client: Dio(BaseOptions(baseUrl: 'http://10.0.2.2:5000/api/v1')),
            baseUrl: '/medicines',
          ),
        ),
      ),
      child: const _SearchPageBody(),
    );
  }
}

class _SearchPageBody extends StatefulWidget {
  const _SearchPageBody({Key? key}) : super(key: key);

  @override
  State<_SearchPageBody> createState() => _SearchPageBodyState();
}

class _SearchPageBodyState extends State<_SearchPageBody> {
  String _query = '';
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    setState(() => _query = query);
    context.read<SearchMedicineCubit>().search(query);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _controller,
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
            onSubmitted: _onSearch,
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
          if (_query.isNotEmpty)
            Text(
              'Results for: $_query',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          const SizedBox(height: 16),
          Expanded(
            child: BlocBuilder<SearchMedicineCubit, SearchMedicineState>(
              builder: (context, state) {
                if (state is SearchMedicineLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is SearchMedicineError) {
                  return Center(
                      child: Text('Error: ${state.message}',
                          style: const TextStyle(color: Colors.red)));
                } else if (state is SearchMedicineLoaded) {
                  if (state.results.isEmpty) {
                    return const Center(child: Text('No results found.'));
                  }
                  return ListView.builder(
                    itemCount: state.results.length,
                    itemBuilder: (context, index) {
                      final medicine = state.results[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              // Medicine image if available
                              if (medicine.image.isNotEmpty)
                                Container(
                                  width: 80,
                                  height: 80,
                                  margin: const EdgeInsets.only(right: 16),
                                  child: Image.network(
                                    medicine.image,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                )
                              else
                                Container(
                                  width: 80,
                                  height: 80,
                                  color: Colors.grey[300],
                                  margin: const EdgeInsets.only(right: 16),
                                ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(medicine.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16)),
                                    const SizedBox(height: 4),
                                    Text('Category: ${medicine.category}',
                                        style: const TextStyle(
                                            color: Colors.grey)),
                                    const SizedBox(height: 8),
                                    Text('Br ${medicine.description}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.green)),
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
                                    icon: const Icon(Icons
                                        .add_shopping_cart), // Or similar icon
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
                  );
                }
                return const Center(
                    child: Text('Search for a medicine above.'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
