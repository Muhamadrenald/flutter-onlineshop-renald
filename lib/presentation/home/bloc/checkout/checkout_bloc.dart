import 'package:bloc/bloc.dart';
import 'package:flutter_onlineshop_renald/presentation/home/models/product_quantity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/models/responses/product_response_model.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';
part 'checkout_bloc.freezed.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(const _Loaded([], 0, '', '', 0, '')) {
    on<_AddItem>((event, emit) {
      final currentState = state as _Loaded;
      if (currentState.products
          .any((element) => element.product.id == event.product.id)) {
        final index = currentState.products
            .indexWhere((element) => element.product.id == event.product.id);
        final item = currentState.products[index];
        final newItem = item.copyWith(quantity: item.quantity + 1);
        final newItems =
            currentState.products.map((e) => e == item ? newItem : e).toList();
        emit(_Loaded(
            newItems,
            currentState.addressId,
            currentState.paymentMethod,
            currentState.shippingService,
            currentState.shippingCost,
            currentState.shippingService));
      } else {
        final newItem = ProductQuantity(product: event.product, quantity: 1);
        final newItems = [...currentState.products, newItem];
        emit(_Loaded(
            newItems,
            currentState.addressId,
            currentState.paymentMethod,
            currentState.shippingService,
            currentState.shippingCost,
            currentState.shippingService));
      }
    });

    on<_RemoveItem>((event, emit) {
      final currentState = state as _Loaded;
      if (currentState.products
          .any((element) => element.product.id == event.product.id)) {
        final index = currentState.products
            .indexWhere((element) => element.product.id == event.product.id);
        final item = currentState.products[index];
        //if quantity is 1, remove the item
        if (item.quantity == 1) {
          final newItems = currentState.products
              .where((element) => element.product.id != event.product.id)
              .toList();
          emit(_Loaded(
              newItems,
              currentState.addressId,
              currentState.paymentMethod,
              currentState.shippingService,
              currentState.shippingCost,
              currentState.shippingService));
        } else {
          final newItem = item.copyWith(quantity: item.quantity - 1);
          final newItems = currentState.products
              .map((e) => e == item ? newItem : e)
              .toList();
          emit(_Loaded(
              newItems,
              currentState.addressId,
              currentState.paymentMethod,
              currentState.shippingService,
              currentState.shippingCost,
              currentState.shippingService));
        }
      }
    });

    on<_AddAddressId>((event, emit) {
      final currentState = state as _Loaded;
      emit(_Loaded(
          currentState.products,
          event.addressId,
          currentState.paymentMethod,
          currentState.shippingService,
          currentState.shippingCost,
          currentState.shippingService));
    });

    on<_AddPaymentMethod>((event, emit) {
      final currentState = state as _Loaded;
      emit(_Loaded(
          currentState.products,
          currentState.addressId,
          'bank_transfer',
          currentState.shippingService,
          currentState.shippingCost,
          event.paymentMethod));
    });

    on<_AddShippingService>((event, emit) {
      final currentState = state as _Loaded;
      emit(_Loaded(
          currentState.products,
          currentState.addressId,
          currentState.paymentMethod,
          event.shippingService,
          event.shippingCost,
          currentState.paymentMethod));
    });

    //on started
    on<_Started>((event, emit) {
      emit(const _Loaded([], 0, '', '', 0, ''));
    });
  }
}
