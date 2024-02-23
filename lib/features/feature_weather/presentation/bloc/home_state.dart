part of 'home_bloc.dart';

class HomeState extends Equatable {
  final CurrentWeatherStatus currentWeatherStatus;
  final ForecastDaysStatus forecastDaysStatus;
  final WeatherInformationStatus informationStatus;
  final MainDataStatus mainDataStatus;

  const HomeState({
    required this.mainDataStatus,
    required this.informationStatus,
    required this.forecastDaysStatus,
    required this.currentWeatherStatus,
  });

  HomeState copyWith({
    CurrentWeatherStatus? currentWeatherStatus,
    ForecastDaysStatus? forecastDaysStatus,
    WeatherInformationStatus? informationStatus,
    MainDataStatus? mainDataStatus,
  }) {
    return HomeState(
      mainDataStatus: mainDataStatus ?? this.mainDataStatus,
      currentWeatherStatus: currentWeatherStatus ?? this.currentWeatherStatus,
      forecastDaysStatus: forecastDaysStatus ?? this.forecastDaysStatus,
      informationStatus: informationStatus ?? this.informationStatus,
    );
  }

  @override
  List<Object?> get props => [
        currentWeatherStatus,
        forecastDaysStatus,
        informationStatus,
        mainDataStatus,
      ];
}
