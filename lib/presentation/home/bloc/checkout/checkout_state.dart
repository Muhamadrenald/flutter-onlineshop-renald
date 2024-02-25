part of 'checkout_bloc.dart';

@freezed
class CheckoutState with _$CheckoutState {
  const factory CheckoutState.initial() = _Initial;
  const factory CheckoutState.loading() = _Loading;
  // "payment_method" : "bank_transfer",
  //           "shipping_service": "jne",
  //           "shipping_cost":25000,
  //           "payment_va_name":"bri",
  const factory CheckoutState.loaded(
    List<ProductQuantity> products,
    int addressId,
    String paymentMethod,
    String shippingService,
    int shippingCost,
    String paymentVaName,
  ) = _Loaded;
  const factory CheckoutState.error(String message) = _Error;
}
