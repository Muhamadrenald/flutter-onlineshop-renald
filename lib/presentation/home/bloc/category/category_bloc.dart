import 'package:bloc/bloc.dart';
import 'package:flutter_onlineshop_renald/data/datasources/category_remote_datasource.dart';
import 'package:flutter_onlineshop_renald/data/models/responses/category_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_bloc.freezed.dart';
part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRemoteDatasource _categoryRemoteDatasource;
  CategoryBloc(
    this._categoryRemoteDatasource,
  ) : super(const _Initial()) {
    on<_GetCategories>((event, emit) async {
      emit(const CategoryState.loading());
      final response = await _categoryRemoteDatasource.getCategories();
      response.fold(
        (l) => emit(const CategoryState.error('Internal Server Error')),
        (r) => emit(CategoryState.loaded(r.data!)),
      );
    });
  }
}
