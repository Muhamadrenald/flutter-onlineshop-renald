import 'package:dartz/dartz.dart';
import 'package:flutter_onlineshop_renald/data/models/responses/city_response_model.dart';
import 'package:flutter_onlineshop_renald/data/models/responses/cost_response_model.dart';
import 'package:flutter_onlineshop_renald/data/models/responses/province_response_model.dart';
import 'package:flutter_onlineshop_renald/data/models/responses/subdistrict_response_model.dart';
import 'package:flutter_onlineshop_renald/data/models/responses/tracking_response_model.dart';
import 'package:http/http.dart' as http;

import '../../core/constants/variables.dart';

class RajaongkirRemoteDatasource {
  Future<Either<String, ProvinceResponseModel>> getProvinces() async {
    final url = Uri.parse('https://pro.rajaongkir.com/api/province');
    final response = await http.get(
      url,
      headers: {
        'key': Variables.rajaOngkirKey,
      },
    );
    if (response.statusCode == 200) {
      return right(ProvinceResponseModel.fromJson(response.body));
    } else {
      return left('Error');
    }
  }

  //city by province
  Future<Either<String, CityResponseModel>> getCitiesByProvince(
      String provinceId) async {
    final url =
        Uri.parse('https://pro.rajaongkir.com/api/city?province=$provinceId');
    final response = await http.get(
      url,
      headers: {
        'key': Variables.rajaOngkirKey,
      },
    );
    if (response.statusCode == 200) {
      return right(CityResponseModel.fromJson(response.body));
    } else {
      return left('Error');
    }
  }

  //district by city
  Future<Either<String, SubdistrictResponseModel>> getSubdistrictsByCity(
      String cityId) async {
    final url =
        Uri.parse('https://pro.rajaongkir.com/api/subdistrict?city=$cityId');
    final response = await http.get(
      url,
      headers: {
        'key': Variables.rajaOngkirKey,
      },
    );
    if (response.statusCode == 200) {
      return right(SubdistrictResponseModel.fromJson(response.body));
    } else {
      return left('Error');
    }
  }

  Future<Either<String, CostResponseModel>> getCost(
      String origin, String destination, String courier) async {
    final url = Uri.parse('https://pro.rajaongkir.com/api/cost');
    final response = await http.post(
      url,
      headers: {
        'key': Variables.rajaOngkirKey,
      },
      body: {
        'origin': origin,
        'originType': 'subdistrict',
        'destination': destination,
        'destinationType': 'subdistrict',
        'weight': '1000',
        'courier': courier,
      },
    );
    if (response.statusCode == 200) {
      return right(CostResponseModel.fromJson(response.body));
    } else {
      return left('Error');
    }
  }

  //tracking
  Future<Either<String, TrackingResponseModel>> getWaybill(
      String courier, String waybill) async {
    final url = Uri.parse('https://pro.rajaongkir.com/api/waybill');
    final response = await http.post(
      url,
      headers: {
        'key': Variables.rajaOngkirKey,
      },
      body: {
        'waybill': waybill,
        'courier': courier,
      },
    );
    if (response.statusCode == 200) {
      return right(TrackingResponseModel.fromJson(response.body));
    } else {
      return left('Error');
    }
  }
}
