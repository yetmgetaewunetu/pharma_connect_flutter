import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharma_connect_flutter/application/blocs/orders/orders_bloc.dart';
import 'package:pharma_connect_flutter/domain/entities/order/order.dart';
import 'package:pharma_connect_flutter/presentation/widgets/loading_indicator.dart';
import 'package:pharma_connect_flutter/presentation/widgets/error_dialog.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: BlocConsumer<OrdersBloc, OrdersState>(
        listener: (context, state) {
          state.maybeWhen(
            error: (message) => showDialog(
              context: context,
              builder: (context) => ErrorDialog(message: message),
            ),
            orElse: () {},
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(child: LoadingIndicator()),
            loaded: (orders) => orders.isEmpty
                ? const Center(child: Text('No orders yet'))
                : ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      return OrderCard(order: order);
                    },
                  ),
            error: (message) => Center(child: Text(message)),
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  const OrderCard({
    Key? key,
    required this.order,
  }) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ExpansionTile(
        title: Text('Order #${order.id}'),
        subtitle: Text(
          '${order.date.toString().split(' ')[0]} - \$${order.total.toStringAsFixed(2)}',
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Status: ${order.status}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text('Shipping Address: ${order.shippingAddress}'),
                const SizedBox(height: 8),
                Text('Payment Method: ${order.paymentMethod}'),
                const SizedBox(height: 16),
                const Text(
                  'Items:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ...order.items.map(
                  (item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(item.name),
                        Text(
                          '${item.quantity}x \$${item.price.toStringAsFixed(2)}',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 