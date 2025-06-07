// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderImpl _$$OrderImplFromJson(Map<String, dynamic> json) => _$OrderImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toDouble(),
      status: json['status'] as String,
      date: DateTime.parse(json['date'] as String),
      shippingAddress: json['shippingAddress'] as String,
      paymentMethod: json['paymentMethod'] as String,
    );

Map<String, dynamic> _$$OrderImplToJson(_$OrderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'items': instance.items,
      'total': instance.total,
      'status': instance.status,
      'date': instance.date.toIso8601String(),
      'shippingAddress': instance.shippingAddress,
      'paymentMethod': instance.paymentMethod,
    };
