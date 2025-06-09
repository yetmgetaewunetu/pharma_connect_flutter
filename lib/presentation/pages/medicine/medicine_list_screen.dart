import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharma_connect_flutter/application/blocs/medicine/list_medicine_bloc.dart';
import 'package:pharma_connect_flutter/domain/entities/medicine/medicine.dart';
import 'package:pharma_connect_flutter/presentation/widgets/loading_indicator.dart';
import 'package:pharma_connect_flutter/presentation/widgets/error_dialog.dart';

class MedicineListScreen extends StatefulWidget {
  const MedicineListScreen({Key? key}) : super(key: key);

  @override
  State<MedicineListScreen> createState() => _MedicineListScreenState();
}

class _MedicineListScreenState extends State<MedicineListScreen> {
  @override
  void initState() {
    super.initState();
    // Load medicines when the screen is first displayed
    context.read<ListMedicineBloc>().add(const ListMedicineEvent.loaded());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicines'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchBar(
              onChanged: (query) {
                if (query.isEmpty) {
                  context
                      .read<ListMedicineBloc>()
                      .add(const ListMedicineEvent.loaded());
                } else {
                  context
                      .read<ListMedicineBloc>()
                      .add(ListMedicineEvent.searched(query));
                }
              },
            ),
          ),
          Expanded(
            child: BlocConsumer<ListMedicineBloc, ListMedicineState>(
              listener: (context, state) {
                state.maybeWhen(
                  error: (message) {
                    showDialog(
                      context: context,
                      builder: (context) => ErrorDialog(message: message),
                    );
                  },
                  orElse: () {},
                );
              },
              builder: (context, state) {
                return state.maybeWhen(
                  loading: () => const LoadingIndicator(),
                  loaded: (medicines) => MedicineList(medicines: medicines),
                  orElse: () => const SizedBox.shrink(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  final Function(String) onChanged;

  const SearchBar({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search medicines...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onChanged: onChanged,
    );
  }
}

class MedicineList extends StatelessWidget {
  final List<Medicine> medicines;

  const MedicineList({
    Key? key,
    required this.medicines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: medicines.length,
      itemBuilder: (context, index) {
        final medicine = medicines[index];
        return MedicineCard(medicine: medicine);
      },
    );
  }
}

class MedicineCard extends StatelessWidget {
  final Medicine medicine;

  const MedicineCard({
    Key? key,
    required this.medicine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(medicine.name),
        subtitle: Text(medicine.description),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/medicine/details',
            arguments: medicine,
          );
        },
        trailing: PopupMenuButton<String>(
          onSelected: (value) async {
            if (value == 'edit') {
              // TODO: Implement EditMedicineScreen and navigation
              Navigator.pushNamed(
                context,
                '/medicine/edit',
                arguments: medicine,
              );
            } else if (value == 'delete') {
              // TODO: Implement delete logic
              final bloc = context.read<ListMedicineBloc>();
              final repo =
                  bloc.repository; // You may need to expose this or use DI
              final result = await repo.deleteMedicine(medicine.id);
              result.fold(
                (failure) => showDialog(
                  context: context,
                  builder: (context) => ErrorDialog(message: failure.message),
                ),
                (_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Medicine deleted successfully!')),
                  );
                  bloc.add(const ListMedicineEvent.loaded());
                },
              );
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'edit',
              child: Text('Edit'),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}
