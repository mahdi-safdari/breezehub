import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@entity
class CityEntity extends Equatable {
  @PrimaryKey(autoGenerate: true)
  int? id;
  final String name;
  final String description;
  final String icon;
  final double temp;
  final double tempMax;
  final double tempMin;
  final double lat;
  final double lon;

  CityEntity({
    required this.name,
    required this.description,
    required this.icon,
    required this.temp,
    required this.tempMax,
    required this.tempMin,
    required this.lat,
    required this.lon,
  });

  @override
  List<Object?> get props => [
        name,
        description,
        icon,
        temp,
        tempMax,
        tempMin,
        lat,
        lon,
      ];
}
