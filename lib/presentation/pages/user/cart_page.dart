import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharma_connect_flutter/application/blocs/cart/cart_bloc.dart';
import 'package:pharma_connect_flutter/infrastructure/repositories/cart_repository_impl.dart';
import 'package:pharma_connect_flutter/infrastructure/datasources/cart_api.dart';
import 'package:get_it/get_it.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CartBloc(CartRepositoryImpl(GetIt.I<CartApi>()))
        ..add(const CartEvent.loadCart()),
      child: const _CartPageBody(),
    );
  }
}

class _CartPageBody extends StatelessWidget {
  const _CartPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Saved Medicines'),
        actions: [
          TextButton(
            onPressed: () {
              context.read<CartBloc>().add(const CartEvent.clearCart());
            },
            child:
                const Text('Remove All', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (message) {
              if (message.toLowerCase().contains('not found')) {
                return const Center(child: Text('Your cart is empty'));
              }
              return Center(
                child: Text('Error: $message',
                    style: const TextStyle(color: Colors.red)),
              );
            },
            loaded: (items) {
              if (items.isEmpty) {
                return const Center(child: Text('Your cart is empty'));
              }
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: RefreshIndicator(
                  onRefresh: () async {
                    context.read<CartBloc>().add(const CartEvent.loadCart());
                  },
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              if (item.photo.isNotEmpty)
                                Container(
                                  width: 80,
                                  height: 80,
                                  margin: const EdgeInsets.only(right: 16),
                                  child: Image.network(
                                    item.photo,
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
                                    Text(item.medicineName,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16)),
                                    const SizedBox(height: 4),
                                    Text('Pharmacy: ${item.pharmacyName}',
                                        style: const TextStyle(
                                            color: Colors.grey)),
                                    const SizedBox(height: 8),
                                    Text(
                                        'Price: Br ${item.price.toStringAsFixed(2)}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 4),
                                    Text('Quantity: ${item.quantity}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  context.read<CartBloc>().add(
                                      CartEvent.removeItem(item.inventoryId));
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
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<CartBloc>().add(const CartEvent.loadCart());
        },
        child: const Icon(Icons.refresh),
        tooltip: 'Refresh',
      ),
    );
  }
}
