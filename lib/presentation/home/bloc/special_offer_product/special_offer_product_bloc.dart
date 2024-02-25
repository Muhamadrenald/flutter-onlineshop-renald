import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/datasources/product_remote_datasource.dart';
import '../../../../data/models/responses/product_response_model.dart';

part 'special_offer_product_bloc.freezed.dart';
part 'special_offer_product_event.dart';
part 'special_offer_product_state.dart';

class SpecialOfferProductBloc
    extends Bloc<SpecialOfferProductEvent, SpecialOfferProductState> {
  final ProductRemoteDatasource _productRemoteDatasource;
  SpecialOfferProductBloc(
    this._productRemoteDatasource,
  ) : super(const _Initial()) {
    on<SpecialOfferProductEvent>((event, emit) async {
      emit(const SpecialOfferProductState.loading());
      // final response = await _productRemoteDatasource.getProductByCategory(7);
      final response = await _productRemoteDatasource.getProductByCategory(3);
      response.fold(
        (l) =>
            emit(const SpecialOfferProductState.error('Internal Server Error')),
        (r) => emit(SpecialOfferProductState.loaded(r.data!.data!)),
      );
    });
  }
}
