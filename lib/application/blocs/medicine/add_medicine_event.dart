part of 'add_medicine_bloc.dart';

@freezed
class AddMedicineEvent with _$AddMedicineEvent {
  const factory AddMedicineEvent.submitted(Medicine medicine) = _Submitted;
} 