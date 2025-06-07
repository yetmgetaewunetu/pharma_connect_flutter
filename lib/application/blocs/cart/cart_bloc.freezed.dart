// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CartEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadCart,
    required TResult Function(CartItem item) addItem,
    required TResult Function(String itemId) removeItem,
    required TResult Function(String itemId, int quantity) updateQuantity,
    required TResult Function() clearCart,
    required TResult Function() checkout,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadCart,
    TResult? Function(CartItem item)? addItem,
    TResult? Function(String itemId)? removeItem,
    TResult? Function(String itemId, int quantity)? updateQuantity,
    TResult? Function()? clearCart,
    TResult? Function()? checkout,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadCart,
    TResult Function(CartItem item)? addItem,
    TResult Function(String itemId)? removeItem,
    TResult Function(String itemId, int quantity)? updateQuantity,
    TResult Function()? clearCart,
    TResult Function()? checkout,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadCart value) loadCart,
    required TResult Function(_AddItem value) addItem,
    required TResult Function(_RemoveItem value) removeItem,
    required TResult Function(_UpdateQuantity value) updateQuantity,
    required TResult Function(_ClearCart value) clearCart,
    required TResult Function(_Checkout value) checkout,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadCart value)? loadCart,
    TResult? Function(_AddItem value)? addItem,
    TResult? Function(_RemoveItem value)? removeItem,
    TResult? Function(_UpdateQuantity value)? updateQuantity,
    TResult? Function(_ClearCart value)? clearCart,
    TResult? Function(_Checkout value)? checkout,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadCart value)? loadCart,
    TResult Function(_AddItem value)? addItem,
    TResult Function(_RemoveItem value)? removeItem,
    TResult Function(_UpdateQuantity value)? updateQuantity,
    TResult Function(_ClearCart value)? clearCart,
    TResult Function(_Checkout value)? checkout,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartEventCopyWith<$Res> {
  factory $CartEventCopyWith(CartEvent value, $Res Function(CartEvent) then) =
      _$CartEventCopyWithImpl<$Res, CartEvent>;
}

/// @nodoc
class _$CartEventCopyWithImpl<$Res, $Val extends CartEvent>
    implements $CartEventCopyWith<$Res> {
  _$CartEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CartEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadCartImplCopyWith<$Res> {
  factory _$$LoadCartImplCopyWith(
          _$LoadCartImpl value, $Res Function(_$LoadCartImpl) then) =
      __$$LoadCartImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadCartImplCopyWithImpl<$Res>
    extends _$CartEventCopyWithImpl<$Res, _$LoadCartImpl>
    implements _$$LoadCartImplCopyWith<$Res> {
  __$$LoadCartImplCopyWithImpl(
      _$LoadCartImpl _value, $Res Function(_$LoadCartImpl) _then)
      : super(_value, _then);

  /// Create a copy of CartEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadCartImpl implements _LoadCart {
  const _$LoadCartImpl();

  @override
  String toString() {
    return 'CartEvent.loadCart()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadCartImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadCart,
    required TResult Function(CartItem item) addItem,
    required TResult Function(String itemId) removeItem,
    required TResult Function(String itemId, int quantity) updateQuantity,
    required TResult Function() clearCart,
    required TResult Function() checkout,
  }) {
    return loadCart();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadCart,
    TResult? Function(CartItem item)? addItem,
    TResult? Function(String itemId)? removeItem,
    TResult? Function(String itemId, int quantity)? updateQuantity,
    TResult? Function()? clearCart,
    TResult? Function()? checkout,
  }) {
    return loadCart?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadCart,
    TResult Function(CartItem item)? addItem,
    TResult Function(String itemId)? removeItem,
    TResult Function(String itemId, int quantity)? updateQuantity,
    TResult Function()? clearCart,
    TResult Function()? checkout,
    required TResult orElse(),
  }) {
    if (loadCart != null) {
      return loadCart();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadCart value) loadCart,
    required TResult Function(_AddItem value) addItem,
    required TResult Function(_RemoveItem value) removeItem,
    required TResult Function(_UpdateQuantity value) updateQuantity,
    required TResult Function(_ClearCart value) clearCart,
    required TResult Function(_Checkout value) checkout,
  }) {
    return loadCart(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadCart value)? loadCart,
    TResult? Function(_AddItem value)? addItem,
    TResult? Function(_RemoveItem value)? removeItem,
    TResult? Function(_UpdateQuantity value)? updateQuantity,
    TResult? Function(_ClearCart value)? clearCart,
    TResult? Function(_Checkout value)? checkout,
  }) {
    return loadCart?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadCart value)? loadCart,
    TResult Function(_AddItem value)? addItem,
    TResult Function(_RemoveItem value)? removeItem,
    TResult Function(_UpdateQuantity value)? updateQuantity,
    TResult Function(_ClearCart value)? clearCart,
    TResult Function(_Checkout value)? checkout,
    required TResult orElse(),
  }) {
    if (loadCart != null) {
      return loadCart(this);
    }
    return orElse();
  }
}

abstract class _LoadCart implements CartEvent {
  const factory _LoadCart() = _$LoadCartImpl;
}

/// @nodoc
abstract class _$$AddItemImplCopyWith<$Res> {
  factory _$$AddItemImplCopyWith(
          _$AddItemImpl value, $Res Function(_$AddItemImpl) then) =
      __$$AddItemImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CartItem item});

  $CartItemCopyWith<$Res> get item;
}

/// @nodoc
class __$$AddItemImplCopyWithImpl<$Res>
    extends _$CartEventCopyWithImpl<$Res, _$AddItemImpl>
    implements _$$AddItemImplCopyWith<$Res> {
  __$$AddItemImplCopyWithImpl(
      _$AddItemImpl _value, $Res Function(_$AddItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of CartEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item = null,
  }) {
    return _then(_$AddItemImpl(
      null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as CartItem,
    ));
  }

  /// Create a copy of CartEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CartItemCopyWith<$Res> get item {
    return $CartItemCopyWith<$Res>(_value.item, (value) {
      return _then(_value.copyWith(item: value));
    });
  }
}

/// @nodoc

class _$AddItemImpl implements _AddItem {
  const _$AddItemImpl(this.item);

  @override
  final CartItem item;

  @override
  String toString() {
    return 'CartEvent.addItem(item: $item)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddItemImpl &&
            (identical(other.item, item) || other.item == item));
  }

  @override
  int get hashCode => Object.hash(runtimeType, item);

  /// Create a copy of CartEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddItemImplCopyWith<_$AddItemImpl> get copyWith =>
      __$$AddItemImplCopyWithImpl<_$AddItemImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadCart,
    required TResult Function(CartItem item) addItem,
    required TResult Function(String itemId) removeItem,
    required TResult Function(String itemId, int quantity) updateQuantity,
    required TResult Function() clearCart,
    required TResult Function() checkout,
  }) {
    return addItem(item);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadCart,
    TResult? Function(CartItem item)? addItem,
    TResult? Function(String itemId)? removeItem,
    TResult? Function(String itemId, int quantity)? updateQuantity,
    TResult? Function()? clearCart,
    TResult? Function()? checkout,
  }) {
    return addItem?.call(item);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadCart,
    TResult Function(CartItem item)? addItem,
    TResult Function(String itemId)? removeItem,
    TResult Function(String itemId, int quantity)? updateQuantity,
    TResult Function()? clearCart,
    TResult Function()? checkout,
    required TResult orElse(),
  }) {
    if (addItem != null) {
      return addItem(item);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadCart value) loadCart,
    required TResult Function(_AddItem value) addItem,
    required TResult Function(_RemoveItem value) removeItem,
    required TResult Function(_UpdateQuantity value) updateQuantity,
    required TResult Function(_ClearCart value) clearCart,
    required TResult Function(_Checkout value) checkout,
  }) {
    return addItem(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadCart value)? loadCart,
    TResult? Function(_AddItem value)? addItem,
    TResult? Function(_RemoveItem value)? removeItem,
    TResult? Function(_UpdateQuantity value)? updateQuantity,
    TResult? Function(_ClearCart value)? clearCart,
    TResult? Function(_Checkout value)? checkout,
  }) {
    return addItem?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadCart value)? loadCart,
    TResult Function(_AddItem value)? addItem,
    TResult Function(_RemoveItem value)? removeItem,
    TResult Function(_UpdateQuantity value)? updateQuantity,
    TResult Function(_ClearCart value)? clearCart,
    TResult Function(_Checkout value)? checkout,
    required TResult orElse(),
  }) {
    if (addItem != null) {
      return addItem(this);
    }
    return orElse();
  }
}

abstract class _AddItem implements CartEvent {
  const factory _AddItem(final CartItem item) = _$AddItemImpl;

  CartItem get item;

  /// Create a copy of CartEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddItemImplCopyWith<_$AddItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RemoveItemImplCopyWith<$Res> {
  factory _$$RemoveItemImplCopyWith(
          _$RemoveItemImpl value, $Res Function(_$RemoveItemImpl) then) =
      __$$RemoveItemImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String itemId});
}

/// @nodoc
class __$$RemoveItemImplCopyWithImpl<$Res>
    extends _$CartEventCopyWithImpl<$Res, _$RemoveItemImpl>
    implements _$$RemoveItemImplCopyWith<$Res> {
  __$$RemoveItemImplCopyWithImpl(
      _$RemoveItemImpl _value, $Res Function(_$RemoveItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of CartEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemId = null,
  }) {
    return _then(_$RemoveItemImpl(
      null == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RemoveItemImpl implements _RemoveItem {
  const _$RemoveItemImpl(this.itemId);

  @override
  final String itemId;

  @override
  String toString() {
    return 'CartEvent.removeItem(itemId: $itemId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoveItemImpl &&
            (identical(other.itemId, itemId) || other.itemId == itemId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, itemId);

  /// Create a copy of CartEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RemoveItemImplCopyWith<_$RemoveItemImpl> get copyWith =>
      __$$RemoveItemImplCopyWithImpl<_$RemoveItemImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadCart,
    required TResult Function(CartItem item) addItem,
    required TResult Function(String itemId) removeItem,
    required TResult Function(String itemId, int quantity) updateQuantity,
    required TResult Function() clearCart,
    required TResult Function() checkout,
  }) {
    return removeItem(itemId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadCart,
    TResult? Function(CartItem item)? addItem,
    TResult? Function(String itemId)? removeItem,
    TResult? Function(String itemId, int quantity)? updateQuantity,
    TResult? Function()? clearCart,
    TResult? Function()? checkout,
  }) {
    return removeItem?.call(itemId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadCart,
    TResult Function(CartItem item)? addItem,
    TResult Function(String itemId)? removeItem,
    TResult Function(String itemId, int quantity)? updateQuantity,
    TResult Function()? clearCart,
    TResult Function()? checkout,
    required TResult orElse(),
  }) {
    if (removeItem != null) {
      return removeItem(itemId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadCart value) loadCart,
    required TResult Function(_AddItem value) addItem,
    required TResult Function(_RemoveItem value) removeItem,
    required TResult Function(_UpdateQuantity value) updateQuantity,
    required TResult Function(_ClearCart value) clearCart,
    required TResult Function(_Checkout value) checkout,
  }) {
    return removeItem(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadCart value)? loadCart,
    TResult? Function(_AddItem value)? addItem,
    TResult? Function(_RemoveItem value)? removeItem,
    TResult? Function(_UpdateQuantity value)? updateQuantity,
    TResult? Function(_ClearCart value)? clearCart,
    TResult? Function(_Checkout value)? checkout,
  }) {
    return removeItem?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadCart value)? loadCart,
    TResult Function(_AddItem value)? addItem,
    TResult Function(_RemoveItem value)? removeItem,
    TResult Function(_UpdateQuantity value)? updateQuantity,
    TResult Function(_ClearCart value)? clearCart,
    TResult Function(_Checkout value)? checkout,
    required TResult orElse(),
  }) {
    if (removeItem != null) {
      return removeItem(this);
    }
    return orElse();
  }
}

abstract class _RemoveItem implements CartEvent {
  const factory _RemoveItem(final String itemId) = _$RemoveItemImpl;

  String get itemId;

  /// Create a copy of CartEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RemoveItemImplCopyWith<_$RemoveItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateQuantityImplCopyWith<$Res> {
  factory _$$UpdateQuantityImplCopyWith(_$UpdateQuantityImpl value,
          $Res Function(_$UpdateQuantityImpl) then) =
      __$$UpdateQuantityImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String itemId, int quantity});
}

/// @nodoc
class __$$UpdateQuantityImplCopyWithImpl<$Res>
    extends _$CartEventCopyWithImpl<$Res, _$UpdateQuantityImpl>
    implements _$$UpdateQuantityImplCopyWith<$Res> {
  __$$UpdateQuantityImplCopyWithImpl(
      _$UpdateQuantityImpl _value, $Res Function(_$UpdateQuantityImpl) _then)
      : super(_value, _then);

  /// Create a copy of CartEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemId = null,
    Object? quantity = null,
  }) {
    return _then(_$UpdateQuantityImpl(
      null == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as String,
      null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$UpdateQuantityImpl implements _UpdateQuantity {
  const _$UpdateQuantityImpl(this.itemId, this.quantity);

  @override
  final String itemId;
  @override
  final int quantity;

  @override
  String toString() {
    return 'CartEvent.updateQuantity(itemId: $itemId, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateQuantityImpl &&
            (identical(other.itemId, itemId) || other.itemId == itemId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @override
  int get hashCode => Object.hash(runtimeType, itemId, quantity);

  /// Create a copy of CartEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateQuantityImplCopyWith<_$UpdateQuantityImpl> get copyWith =>
      __$$UpdateQuantityImplCopyWithImpl<_$UpdateQuantityImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadCart,
    required TResult Function(CartItem item) addItem,
    required TResult Function(String itemId) removeItem,
    required TResult Function(String itemId, int quantity) updateQuantity,
    required TResult Function() clearCart,
    required TResult Function() checkout,
  }) {
    return updateQuantity(itemId, quantity);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadCart,
    TResult? Function(CartItem item)? addItem,
    TResult? Function(String itemId)? removeItem,
    TResult? Function(String itemId, int quantity)? updateQuantity,
    TResult? Function()? clearCart,
    TResult? Function()? checkout,
  }) {
    return updateQuantity?.call(itemId, quantity);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadCart,
    TResult Function(CartItem item)? addItem,
    TResult Function(String itemId)? removeItem,
    TResult Function(String itemId, int quantity)? updateQuantity,
    TResult Function()? clearCart,
    TResult Function()? checkout,
    required TResult orElse(),
  }) {
    if (updateQuantity != null) {
      return updateQuantity(itemId, quantity);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadCart value) loadCart,
    required TResult Function(_AddItem value) addItem,
    required TResult Function(_RemoveItem value) removeItem,
    required TResult Function(_UpdateQuantity value) updateQuantity,
    required TResult Function(_ClearCart value) clearCart,
    required TResult Function(_Checkout value) checkout,
  }) {
    return updateQuantity(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadCart value)? loadCart,
    TResult? Function(_AddItem value)? addItem,
    TResult? Function(_RemoveItem value)? removeItem,
    TResult? Function(_UpdateQuantity value)? updateQuantity,
    TResult? Function(_ClearCart value)? clearCart,
    TResult? Function(_Checkout value)? checkout,
  }) {
    return updateQuantity?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadCart value)? loadCart,
    TResult Function(_AddItem value)? addItem,
    TResult Function(_RemoveItem value)? removeItem,
    TResult Function(_UpdateQuantity value)? updateQuantity,
    TResult Function(_ClearCart value)? clearCart,
    TResult Function(_Checkout value)? checkout,
    required TResult orElse(),
  }) {
    if (updateQuantity != null) {
      return updateQuantity(this);
    }
    return orElse();
  }
}

abstract class _UpdateQuantity implements CartEvent {
  const factory _UpdateQuantity(final String itemId, final int quantity) =
      _$UpdateQuantityImpl;

  String get itemId;
  int get quantity;

  /// Create a copy of CartEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateQuantityImplCopyWith<_$UpdateQuantityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClearCartImplCopyWith<$Res> {
  factory _$$ClearCartImplCopyWith(
          _$ClearCartImpl value, $Res Function(_$ClearCartImpl) then) =
      __$$ClearCartImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearCartImplCopyWithImpl<$Res>
    extends _$CartEventCopyWithImpl<$Res, _$ClearCartImpl>
    implements _$$ClearCartImplCopyWith<$Res> {
  __$$ClearCartImplCopyWithImpl(
      _$ClearCartImpl _value, $Res Function(_$ClearCartImpl) _then)
      : super(_value, _then);

  /// Create a copy of CartEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearCartImpl implements _ClearCart {
  const _$ClearCartImpl();

  @override
  String toString() {
    return 'CartEvent.clearCart()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearCartImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadCart,
    required TResult Function(CartItem item) addItem,
    required TResult Function(String itemId) removeItem,
    required TResult Function(String itemId, int quantity) updateQuantity,
    required TResult Function() clearCart,
    required TResult Function() checkout,
  }) {
    return clearCart();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadCart,
    TResult? Function(CartItem item)? addItem,
    TResult? Function(String itemId)? removeItem,
    TResult? Function(String itemId, int quantity)? updateQuantity,
    TResult? Function()? clearCart,
    TResult? Function()? checkout,
  }) {
    return clearCart?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadCart,
    TResult Function(CartItem item)? addItem,
    TResult Function(String itemId)? removeItem,
    TResult Function(String itemId, int quantity)? updateQuantity,
    TResult Function()? clearCart,
    TResult Function()? checkout,
    required TResult orElse(),
  }) {
    if (clearCart != null) {
      return clearCart();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadCart value) loadCart,
    required TResult Function(_AddItem value) addItem,
    required TResult Function(_RemoveItem value) removeItem,
    required TResult Function(_UpdateQuantity value) updateQuantity,
    required TResult Function(_ClearCart value) clearCart,
    required TResult Function(_Checkout value) checkout,
  }) {
    return clearCart(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadCart value)? loadCart,
    TResult? Function(_AddItem value)? addItem,
    TResult? Function(_RemoveItem value)? removeItem,
    TResult? Function(_UpdateQuantity value)? updateQuantity,
    TResult? Function(_ClearCart value)? clearCart,
    TResult? Function(_Checkout value)? checkout,
  }) {
    return clearCart?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadCart value)? loadCart,
    TResult Function(_AddItem value)? addItem,
    TResult Function(_RemoveItem value)? removeItem,
    TResult Function(_UpdateQuantity value)? updateQuantity,
    TResult Function(_ClearCart value)? clearCart,
    TResult Function(_Checkout value)? checkout,
    required TResult orElse(),
  }) {
    if (clearCart != null) {
      return clearCart(this);
    }
    return orElse();
  }
}

abstract class _ClearCart implements CartEvent {
  const factory _ClearCart() = _$ClearCartImpl;
}

/// @nodoc
abstract class _$$CheckoutImplCopyWith<$Res> {
  factory _$$CheckoutImplCopyWith(
          _$CheckoutImpl value, $Res Function(_$CheckoutImpl) then) =
      __$$CheckoutImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CheckoutImplCopyWithImpl<$Res>
    extends _$CartEventCopyWithImpl<$Res, _$CheckoutImpl>
    implements _$$CheckoutImplCopyWith<$Res> {
  __$$CheckoutImplCopyWithImpl(
      _$CheckoutImpl _value, $Res Function(_$CheckoutImpl) _then)
      : super(_value, _then);

  /// Create a copy of CartEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CheckoutImpl implements _Checkout {
  const _$CheckoutImpl();

  @override
  String toString() {
    return 'CartEvent.checkout()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CheckoutImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadCart,
    required TResult Function(CartItem item) addItem,
    required TResult Function(String itemId) removeItem,
    required TResult Function(String itemId, int quantity) updateQuantity,
    required TResult Function() clearCart,
    required TResult Function() checkout,
  }) {
    return checkout();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadCart,
    TResult? Function(CartItem item)? addItem,
    TResult? Function(String itemId)? removeItem,
    TResult? Function(String itemId, int quantity)? updateQuantity,
    TResult? Function()? clearCart,
    TResult? Function()? checkout,
  }) {
    return checkout?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadCart,
    TResult Function(CartItem item)? addItem,
    TResult Function(String itemId)? removeItem,
    TResult Function(String itemId, int quantity)? updateQuantity,
    TResult Function()? clearCart,
    TResult Function()? checkout,
    required TResult orElse(),
  }) {
    if (checkout != null) {
      return checkout();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadCart value) loadCart,
    required TResult Function(_AddItem value) addItem,
    required TResult Function(_RemoveItem value) removeItem,
    required TResult Function(_UpdateQuantity value) updateQuantity,
    required TResult Function(_ClearCart value) clearCart,
    required TResult Function(_Checkout value) checkout,
  }) {
    return checkout(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadCart value)? loadCart,
    TResult? Function(_AddItem value)? addItem,
    TResult? Function(_RemoveItem value)? removeItem,
    TResult? Function(_UpdateQuantity value)? updateQuantity,
    TResult? Function(_ClearCart value)? clearCart,
    TResult? Function(_Checkout value)? checkout,
  }) {
    return checkout?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadCart value)? loadCart,
    TResult Function(_AddItem value)? addItem,
    TResult Function(_RemoveItem value)? removeItem,
    TResult Function(_UpdateQuantity value)? updateQuantity,
    TResult Function(_ClearCart value)? clearCart,
    TResult Function(_Checkout value)? checkout,
    required TResult orElse(),
  }) {
    if (checkout != null) {
      return checkout(this);
    }
    return orElse();
  }
}

abstract class _Checkout implements CartEvent {
  const factory _Checkout() = _$CheckoutImpl;
}

/// @nodoc
mixin _$CartState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<CartItem> items) loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<CartItem> items)? loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<CartItem> items)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartStateCopyWith<$Res> {
  factory $CartStateCopyWith(CartState value, $Res Function(CartState) then) =
      _$CartStateCopyWithImpl<$Res, CartState>;
}

/// @nodoc
class _$CartStateCopyWithImpl<$Res, $Val extends CartState>
    implements $CartStateCopyWith<$Res> {
  _$CartStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$CartStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'CartState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<CartItem> items) loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<CartItem> items)? loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<CartItem> items)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements CartState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$CartStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'CartState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<CartItem> items) loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<CartItem> items)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<CartItem> items)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements CartState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<CartItem> items});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$CartStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
  }) {
    return _then(_$LoadedImpl(
      null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<CartItem>,
    ));
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(final List<CartItem> items) : _items = items;

  final List<CartItem> _items;
  @override
  List<CartItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'CartState.loaded(items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_items));

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<CartItem> items) loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(items);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<CartItem> items)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(items);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<CartItem> items)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(items);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements CartState {
  const factory _Loaded(final List<CartItem> items) = _$LoadedImpl;

  List<CartItem> get items;

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$CartStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'CartState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<CartItem> items) loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<CartItem> items)? loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<CartItem> items)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements CartState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
