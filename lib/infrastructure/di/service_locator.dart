import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pharma_connect_flutter/domain/repositories/medicine_repository.dart';
import 'package:pharma_connect_flutter/domain/repositories/auth_repository.dart';
import 'package:pharma_connect_flutter/infrastructure/datasources/remote/medicine_api.dart';
import 'package:pharma_connect_flutter/infrastructure/datasources/auth_api.dart';
import 'package:pharma_connect_flutter/infrastructure/repositories/medicine_repository_impl.dart';
import 'package:pharma_connect_flutter/infrastructure/repositories/auth_repository_impl.dart';
import 'package:pharma_connect_flutter/application/blocs/medicine/add_medicine_bloc.dart';
import 'package:pharma_connect_flutter/application/blocs/medicine/list_medicine_bloc.dart';
import 'package:pharma_connect_flutter/application/blocs/auth/auth_bloc.dart';
import 'package:pharma_connect_flutter/infrastructure/datasources/api_client.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  // Core
  getIt.registerSingleton<ApiClient>(
    ApiClient(),
  );

  // APIs
  getIt.registerSingleton<MedicineApi>(
    MedicineApi(client: getIt<ApiClient>().dio),
  );
  getIt.registerSingleton<AuthApi>(
    AuthApi(getIt<ApiClient>()),
  );

  // Repositories
  getIt.registerSingleton<MedicineRepository>(
    MedicineRepositoryImpl(getIt<MedicineApi>()),
  );
  getIt.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(getIt<AuthApi>()),
  );

  // BLoCs
  getIt.registerFactory(
    () => AddMedicineBloc(getIt<MedicineRepository>()),
  );
  getIt.registerFactory(
    () => ListMedicineBloc(getIt<MedicineRepository>()),
  );
  getIt.registerFactory(
    () => AuthBloc(getIt<AuthRepository>()),
  );
}
