import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharma_connect_flutter/domain/entities/order/order_item.dart';

part 'order.freezed.dart';
part 'order.g.dart';

@freezed
class Order with _$Order {
  const factory Order({
    required String id,
    required String userId,
    required List<OrderItem> items,
    required double total,
    required String status,
    required DateTime date,
    required String shippingAddress,
    required String paymentMethod,
  }) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
} 