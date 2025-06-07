part of 'list_medicine_bloc.dart';

@freezed
class ListMedicineState with _$ListMedicineState {
  const factory ListMedicineState.initial() = _Initial;
  const factory ListMedicineState.loading() = _Loading;
  const factory ListMedicineState.loaded(List<Medicine> medicines) = _Loaded;
  const factory ListMedicineState.error(String message) = _Error;
} 