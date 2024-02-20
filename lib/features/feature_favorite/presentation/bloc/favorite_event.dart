part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteEvent {}

class GetAllCityEvent extends FavoriteEvent {}

class GetCityEvent extends FavoriteEvent {
  final String cityName;

  GetCityEvent(this.cityName);
}

class SaveCityEvent extends FavoriteEvent {
  final CityEntity cityEntity;

  SaveCityEvent(this.cityEntity);
}

class DeleteCityEvent extends FavoriteEvent {
  final String cityName;

  DeleteCityEvent(this.cityName);
}

class SaveCityInitialEvent extends FavoriteEvent {}
