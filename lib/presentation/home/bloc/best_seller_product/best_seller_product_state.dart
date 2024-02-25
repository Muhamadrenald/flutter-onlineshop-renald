part of 'best_seller_product_bloc.dart';

@freezed
class BestSellerProductState with _$BestSellerProductState {
  const factory BestSellerProductState.initial() = _Initial;
  const factory BestSellerProductState.loading() = _Loading;
  const factory BestSellerProductState.loaded(List<Product> products) = _Loaded;
  const factory BestSellerProductState.error(String message) = _Error;
}
