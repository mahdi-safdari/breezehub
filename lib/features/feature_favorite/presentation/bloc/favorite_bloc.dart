import 'package:bloc/bloc.dart';
import 'package:breezehub/core/resources/data_state.dart';
import 'package:breezehub/features/feature_favorite/domain/entities/city_entity.dart';
import 'package:breezehub/features/feature_favorite/domain/usecases/delete_city_usecase.dart';
import 'package:breezehub/features/feature_favorite/domain/usecases/get_all_city_usecase.dart';
import 'package:breezehub/features/feature_favorite/domain/usecases/get_city_usecase.dart';
import 'package:breezehub/features/feature_favorite/domain/usecases/save_city_usecase.dart';
import 'package:breezehub/features/feature_favorite/presentation/bloc/delete_city_status.dart';
import 'package:breezehub/features/feature_favorite/presentation/bloc/get_all_city_status.dart';
import 'package:breezehub/features/feature_favorite/presentation/bloc/get_city_status.dart';
import 'package:breezehub/features/feature_favorite/presentation/bloc/save_city_status.dart';
import 'package:flutter/material.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final SaveCityUseCase saveCityUseCase;
  final GetAllCityUseCase getAllCityUseCase;
  final DeleteCityUseCase deleteCityUseCase;
  final GetCityUseCase getCityUseCase;

  FavoriteBloc(
    this.saveCityUseCase,
    this.getAllCityUseCase,
    this.deleteCityUseCase,
    this.getCityUseCase,
  ) : super(FavoriteState(
          saveCityStatus: SaveCityInitial(),
          getAllCityStatus: GetAllCityLoading(),
          getCityStatus: GetCityLoading(),
          deleteCityStatus: DeleteCityLoading(),
        )) {
    on<SaveCityEvent>((event, emit) async {
      emit(state.copyWith(saveCityStatus: SaveCityLoading()));
      final DataState dataState = await saveCityUseCase(event.cityEntity);
      if (dataState is DataSuccess) {
        emit(state.copyWith(saveCityStatus: SaveCityCompleted(dataState.data)));
      }
      if (dataState is DataFailed) {
        emit(state.copyWith(saveCityStatus: SaveCityError(dataState.errorMessage!)));
      }
    });
    on<GetAllCityEvent>((event, emit) async {
      emit(state.copyWith(getAllCityStatus: GetAllCityLoading()));
      final DataState dataState = await getAllCityUseCase(null);
      if (dataState is DataSuccess) {
        emit(state.copyWith(getAllCityStatus: GetAllCityCompleted(dataState.data)));
      }
      if (dataState is DataFailed) {
        emit(state.copyWith(getAllCityStatus: GetAllCityError(dataState.errorMessage!)));
      }
    });
    on<DeleteCityEvent>((event, emit) async {
      emit(state.copyWith(deleteCityStatus: DeleteCityLoading()));
      final DataState dataState = await deleteCityUseCase(event.cityName);
      if (dataState is DataSuccess) {
        emit(state.copyWith(deleteCityStatus: DeleteCityCompleted(dataState.data)));
      }
      if (dataState is DataFailed) {
        emit(state.copyWith(deleteCityStatus: DeleteCityError(dataState.errorMessage!)));
      }
    });
    on<GetCityEvent>((event, emit) async {
      emit(state.copyWith(getCityStatus: GetCityLoading()));
      final DataState dataState = await getCityUseCase(event.cityName);
      if (dataState is DataSuccess) {
        emit(state.copyWith(getCityStatus: GetCityCompleted(dataState.data)));
      }
      if (dataState is DataFailed) {
        emit(state.copyWith(getCityStatus: GetCityError(dataState.errorMessage!)));
      }
    });
    on<SaveCityInitialEvent>((event, emit) {
      emit(state.copyWith(saveCityStatus: SaveCityInitial()));
    });
  }
}
