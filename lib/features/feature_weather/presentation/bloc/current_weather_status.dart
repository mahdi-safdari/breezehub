import 'package:breezehub/features/feature_weather/domain/entities/current_city_entity.dart';
import 'package:equatable/equatable.dart';

abstract class CurrentWeatherStatus extends Equatable {}

class CurrentWeatherLoading extends CurrentWeatherStatus {
  @override
  List<Object?> get props => [];
}

class CurrentWeatherCompleted extends CurrentWeatherStatus {
  final CurrentCityEntity cityEntity;
  CurrentWeatherCompleted(this.cityEntity);

  @override
  List<Object?> get props => [cityEntity];
}

class CurrentWeatherError extends CurrentWeatherStatus {
  final String errorMessage;

  CurrentWeatherError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
