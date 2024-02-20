import 'package:breezehub/features/feature_weather/data/models/weather_information_model.dart';
import 'package:equatable/equatable.dart';

class WeatherInformationEntity extends Equatable {
  final num? lat;
  final num? lon;
  final String? timezone;
  final num? timezoneOffset;
  final Current? current;
  final List<Minutely>? minutely;
  final List<Hourly>? hourly;
  final List<Daily>? daily;
  final List<Alerts>? alerts;

  const WeatherInformationEntity({
    this.lat,
    this.lon,
    this.timezone,
    this.timezoneOffset,
    this.current,
    this.minutely,
    this.hourly,
    this.daily,
    this.alerts,
  });

  @override
  List<Object?> get props => [
        lat,
        lon,
        timezone,
        timezoneOffset,
        current,
        minutely,
        hourly,
        daily,
        alerts,
      ];
}
