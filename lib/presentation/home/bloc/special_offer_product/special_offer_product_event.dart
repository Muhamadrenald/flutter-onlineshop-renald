part of 'special_offer_product_bloc.dart';

@freezed
class SpecialOfferProductEvent with _$SpecialOfferProductEvent {
  const factory SpecialOfferProductEvent.started() = _Started;
  const factory SpecialOfferProductEvent.getSpecialOfferProducts() = _GetSpecialOfferProducts;
}