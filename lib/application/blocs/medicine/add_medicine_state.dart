part of 'add_medicine_bloc.dart';

@freezed
class AddMedicineState with _$AddMedicineState {
  const factory AddMedicineState.initial() = _Initial;
  const factory AddMedicineState.loading() = _Loading;
  const factory AddMedicineState.success() = _Success;
  const factory AddMedicineState.error(String message) = _Error;
} 