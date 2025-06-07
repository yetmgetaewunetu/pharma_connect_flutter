import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharma_connect_flutter/domain/entities/medicine/medicine.dart';
import 'package:pharma_connect_flutter/domain/repositories/medicine_repository.dart';

part 'list_medicine_event.dart';
part 'list_medicine_state.dart';
part 'list_medicine_bloc.freezed.dart';

class ListMedicineBloc extends Bloc<ListMedicineEvent, ListMedicineState> {
  final MedicineRepository repository;

  ListMedicineBloc(this.repository) : super(const ListMedicineState.initial()) {
    on<ListMedicineEvent>((event, emit) async {
      await event.map(
        loaded: (e) => _onLoadMedicines(e, emit),
        searched: (e) => _onSearched(e, emit),
        filteredByCategory: (e) => _onFilteredByCategory(e, emit),
      );
    });
  }

  Future<void> _onLoadMedicines(
      _LoadMedicines event, Emitter<ListMedicineState> emit) async {
    emit(const ListMedicineState.loading());
    final result = await repository.getMedicines();
    result.fold(
      (failure) => emit(ListMedicineState.error(failure.message)),
      (medicines) => emit(ListMedicineState.loaded(medicines)),
    );
  }

  Future<void> _onSearched(
      _Searched event, Emitter<ListMedicineState> emit) async {
    emit(const ListMedicineState.loading());
    final result = await repository.searchMedicines(event.query);
    result.fold(
      (failure) => emit(ListMedicineState.error(failure.message)),
      (medicines) => emit(ListMedicineState.loaded(medicines)),
    );
  }

  Future<void> _onFilteredByCategory(
      _FilteredByCategory event, Emitter<ListMedicineState> emit) async {
    emit(const ListMedicineState.loading());
    final result = await repository.getMedicinesByCategory(event.category);
    result.fold(
      (failure) => emit(ListMedicineState.error(failure.message)),
      (medicines) => emit(ListMedicineState.loaded(medicines)),
    );
  }
}
