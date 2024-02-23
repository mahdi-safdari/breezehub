import 'package:breezehub/features/feature_weather/domain/entities/weather_information_entity.dart';
import 'package:equatable/equatable.dart';

abstract class WeatherInformationStatus extends Equatable {}

class WeatherInformationLoading extends WeatherInformationStatus {
  @override
  List<Object?> get props => [];
}

class WeatherInformationCompleted extends WeatherInformationStatus {
  final WeatherInformationEntity informationEntity;
  WeatherInformationCompleted(this.informationEntity);

  @override
  List<Object?> get props => [informationEntity];
}

class WeatherInformationError extends WeatherInformationStatus {
  final String errorMessage;
  WeatherInformationError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
