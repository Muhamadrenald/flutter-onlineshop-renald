import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_onlineshop_renald/data/datasources/rajaongkir_remote_datasource.dart';

import '../../../../data/models/responses/subdistrict_response_model.dart';

part 'subdistrict_bloc.freezed.dart';
part 'subdistrict_event.dart';
part 'subdistrict_state.dart';

class SubdistrictBloc extends Bloc<SubdistrictEvent, SubdistrictState> {
  final RajaongkirRemoteDatasource rajaongkirRemoteDatasource;
  SubdistrictBloc(
    this.rajaongkirRemoteDatasource,
  ) : super(const _Initial()) {
    on<_GetSubdistricts>((event, emit) async {
      emit(const _Loading());
      final response =
          await rajaongkirRemoteDatasource.getSubdistrictsByCity(event.cityId);
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.rajaongkir?.results ?? [])),
      );
    });
  }
}
