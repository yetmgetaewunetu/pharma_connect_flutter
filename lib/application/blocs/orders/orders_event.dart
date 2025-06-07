part of 'orders_bloc.dart';

@freezed
class OrdersEvent with _$OrdersEvent {
  const factory OrdersEvent.loadOrders() = _LoadOrders;
  const factory OrdersEvent.refreshOrders() = _RefreshOrders;
} 