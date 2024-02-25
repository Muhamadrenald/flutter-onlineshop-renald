import 'package:bloc/bloc.dart';
import 'package:flutter_onlineshop_renald/data/datasources/product_remote_datasource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/models/responses/product_response_model.dart';

part 'all_product_event.dart';
part 'all_product_state.dart';
part 'all_product_bloc.freezed.dart';

class AllProductBloc extends Bloc<AllProductEvent, AllProductState> {
  final ProductRemoteDatasource _productRemoteDatasource;
  AllProductBloc(
    this._productRemoteDatasource,
  ) : super(const _Initial()) {
    on<_GetAllProducts>((event, emit) async {
      emit(const AllProductState.loading());
      final response = await _productRemoteDatasource.getAllProducts();
      response.fold(
        (l) => emit(const AllProductState.error('Internal Server Error')),
        (r) => emit(AllProductState.loaded(r.data!.data!)),
      );
    });
  }
}
