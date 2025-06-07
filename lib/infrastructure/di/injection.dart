import 'package:get_it/get_it.dart';
import 'package:pharma_connect_flutter/application/blocs/auth/auth_bloc.dart';
import 'package:pharma_connect_flutter/application/blocs/cart/cart_bloc.dart';
import 'package:pharma_connect_flutter/application/blocs/orders/orders_bloc.dart';
import 'package:pharma_connect_flutter/application/blocs/admin/medicine/medicine_cubit.dart';
import 'package:pharma_connect_flutter/domain/repositories/auth_repository.dart';
import 'package:pharma_connect_flutter/domain/repositories/cart_repository.dart';
import 'package:pharma_connect_flutter/domain/repositories/order_repository.dart';
import 'package:pharma_connect_flutter/domain/repositories/medicine_repository.dart';
import 'package:pharma_connect_flutter/infrastructure/datasources/api_client.dart';
import 'package:pharma_connect_flutter/infrastructure/datasources/auth_api.dart';
import 'package:pharma_connect_flutter/infrastructure/datasources/cart_api.dart';
import 'package:pharma_connect_flutter/infrastructure/datasources/order_api.dart';
import 'package:pharma_connect_flutter/infrastructure/datasources/remote/medicine_api.dart';
import 'package:pharma_connect_flutter/infrastructure/repositories/auth_repository_impl.dart';
import 'package:pharma_connect_flutter/infrastructure/repositories/cart_repository_impl.dart';
import 'package:pharma_connect_flutter/infrastructure/repositories/order_repository_impl.dart';
import 'package:pharma_connect_flutter/infrastructure/repositories/medicine_repository_impl.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // Core
  getIt.registerLazySingleton<ApiClient>(
    () => ApiClient(),
  );

  // APIs
  getIt.registerLazySingleton<AuthApi>(
    () => AuthApi(getIt<ApiClient>()),
  );
  getIt.registerLazySingleton<OrderApi>(
    () => OrderApi(getIt<ApiClient>()),
  );
  getIt.registerLazySingleton<CartApi>(
    () => CartApi(getIt<ApiClient>()),
  );
  getIt.registerLazySingleton<MedicineApi>(
    () => MedicineApi(client: getIt<ApiClient>().dio),
  );

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<AuthApi>()),
  );
  getIt.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(getIt<OrderApi>()),
  );
  getIt.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(getIt<CartApi>()),
  );
  getIt.registerLazySingleton<MedicineRepository>(
    () => MedicineRepositoryImpl(getIt<MedicineApi>()),
  );

  // BLoCs
  getIt.registerFactory(() => AuthBloc(getIt<AuthRepository>()));
  getIt.registerFactory(() => OrdersBloc(getIt<OrderRepository>()));
  getIt.registerFactory(() => CartBloc(getIt<CartRepository>()));
  getIt.registerFactory(() => MedicineCubit(getIt<MedicineRepository>()));
} 