import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_onlineshop_renald/core/constants/variables.dart';
import 'package:flutter_onlineshop_renald/data/datasources/auth_local_datasource.dart';
import 'package:flutter_onlineshop_renald/data/models/requests/order_request_model.dart';
import 'package:flutter_onlineshop_renald/data/models/responses/history_order_response_model.dart';
import 'package:flutter_onlineshop_renald/data/models/responses/order_response_model.dart';
import 'package:flutter_onlineshop_renald/presentation/orders/pages/history_order_page.dart';
import 'package:http/http.dart' as http;

import '../models/responses/order_detail_response_model.dart';

class OrderRemoteDatasource {
  Future<Either<String, OrderResponseModel>> order(
      OrderRequestModel orderRequestModel) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/order'),
      headers: {
        'Accept': 'application/json',
        'Content-type': 'application/json',
        'Authorization': 'Bearer ${authData!.accessToken}'
      },
      body: orderRequestModel.toJson(),
    );

    if (response.statusCode == 200) {
      return right(OrderResponseModel.fromJson(response.body));
    } else {
      return left('Error');
    }
  }

  Future<Either<String, String>> checkPaymentStatus(int orderId) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/api/order/status/$orderId'),
      headers: {
        'Accept': 'application/json',
        'Content-type': 'application/json',
        'Authorization': 'Bearer ${authData!.accessToken}'
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return right(data['status']);
    } else {
      return left('Error');
    }
  }

  //get orders by user id
  Future<Either<String, HistoryOrderResponseModel>> getOrders() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/api/orders'),
      headers: {
        'Accept': 'application/json',
        'Content-type': 'application/json',
        'Authorization': 'Bearer ${authData!.accessToken}'
      },
    );

    if (response.statusCode == 200) {
      final orderList = HistoryOrderResponseModel.fromJson(response.body);
      return right(orderList);
    } else {
      return left('Error');
    }
  }

  //get order by id
  Future<Either<String, OrderDetailResponseModel>> getOrderById(
      int orderId) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/api/order/$orderId'),
      headers: {
        'Accept': 'application/json',
        'Content-type': 'application/json',
        'Authorization': 'Bearer ${authData!.accessToken}'
      },
    );

    if (response.statusCode == 200) {
      final order = OrderDetailResponseModel.fromJson(response.body);
      return right(order);
    } else {
      return left('Error');
    }
  }
}
