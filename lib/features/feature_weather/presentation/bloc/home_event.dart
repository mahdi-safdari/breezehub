part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {}

class CurrentWeatherEvent extends HomeEvent {
  final String cityName;
  CurrentWeatherEvent(this.cityName);

  @override
  List<Object?> get props => [cityName];
}

class ForecastDaysEvent extends HomeEvent {
  final String cityName;
  ForecastDaysEvent(this.cityName);

  @override
  List<Object?> get props => [cityName];
}

class WeatherInformationEvent extends HomeEvent {
  final LocationParams locationParams;
  WeatherInformationEvent(this.locationParams);

  @override
  List<Object?> get props => throw UnimplementedError();
}

class MainDataEvent extends HomeEvent {
  final LocationParams params;

  MainDataEvent(this.params);
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
