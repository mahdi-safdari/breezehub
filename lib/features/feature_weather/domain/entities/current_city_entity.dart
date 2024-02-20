import 'package:breezehub/features/feature_weather/data/models/current_city_model.dart';
import 'package:equatable/equatable.dart';

class CurrentCityEntity extends Equatable {
  final Coord? coord;
  final List<Weather>? weather;
  final String? base;
  final Main? main;
  final num? visibility;
  final Wind? wind;
  final Clouds? clouds;
  final num? dt;
  final Sys? sys;
  final num? id;
  final String? name;
  final num? cod;
  final int? timezone;

  const CurrentCityEntity({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.clouds,
    this.dt,
    this.sys,
    this.id,
    this.name,
    this.cod,
    this.timezone,
  });

  @override
  List<Object?> get props => [
        coord,
        weather,
        base,
        main,
        visibility,
        wind,
        clouds,
        dt,
        sys,
        id,
        name,
        cod,
      ];
}
