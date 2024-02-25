part of 'special_offer_product_bloc.dart';

@freezed
class SpecialOfferProductState with _$SpecialOfferProductState {
  const factory SpecialOfferProductState.initial() = _Initial;
  const factory SpecialOfferProductState.loading() = _Loading;
  const factory SpecialOfferProductState.loaded(List<Product> products) = _Loaded;
  const factory SpecialOfferProductState.error(String message) = _Error;
}
