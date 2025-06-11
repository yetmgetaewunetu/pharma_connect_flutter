import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharma_connect_flutter/domain/entities/medicine/medicine.dart';
import 'package:pharma_connect_flutter/domain/repositories/medicine_repository.dart';

abstract class SearchMedicineState {}

class SearchMedicineInitial extends SearchMedicineState {}

class SearchMedicineLoading extends SearchMedicineState {}

class SearchMedicineLoaded extends SearchMedicineState {
  final List<MedicineSearchResult> results;
  SearchMedicineLoaded(this.results);
}

class SearchMedicineError extends SearchMedicineState {
  final String message;
  SearchMedicineError(this.message);
}

class SearchMedicineCubit extends Cubit<SearchMedicineState> {
  final MedicineRepository repository;
  SearchMedicineCubit(this.repository) : super(SearchMedicineInitial());

  Future<void> search(String query) async {
    emit(SearchMedicineLoading());
    try {
      final response = await repository.searchPharmacyInventory(query);
      response.fold(
        (failure) => emit(SearchMedicineError(failure.message)),
        (results) => emit(SearchMedicineLoaded(results)),
      );
    } catch (e) {
      emit(SearchMedicineError(e.toString()));
    }
  }
}
 