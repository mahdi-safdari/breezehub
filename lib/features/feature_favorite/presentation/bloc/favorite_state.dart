part of 'favorite_bloc.dart';

class FavoriteState {
  final SaveCityStatus saveCityStatus;
  final GetAllCityStatus getAllCityStatus;
  final GetCityStatus getCityStatus;
  final DeleteCityStatus deleteCityStatus;

  FavoriteState({
    required this.saveCityStatus,
    required this.getAllCityStatus,
    required this.getCityStatus,
    required this.deleteCityStatus,
  });

  FavoriteState copyWith({
    SaveCityStatus? saveCityStatus,
    GetAllCityStatus? getAllCityStatus,
    GetCityStatus? getCityStatus,
    DeleteCityStatus? deleteCityStatus,
  }) {
    return FavoriteState(
      saveCityStatus: saveCityStatus ?? this.saveCityStatus,
      getAllCityStatus: getAllCityStatus ?? this.getAllCityStatus,
      getCityStatus: getCityStatus ?? this.getCityStatus,
      deleteCityStatus: deleteCityStatus ?? this.deleteCityStatus,
    );
  }
}
