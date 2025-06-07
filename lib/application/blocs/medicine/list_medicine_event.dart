part of 'list_medicine_bloc.dart';

@freezed
class ListMedicineEvent with _$ListMedicineEvent {
  const factory ListMedicineEvent.loaded() = _LoadMedicines;
  const factory ListMedicineEvent.searched(String query) = _Searched;
  const factory ListMedicineEvent.filteredByCategory(String category) =
      _FilteredByCategory;
}
