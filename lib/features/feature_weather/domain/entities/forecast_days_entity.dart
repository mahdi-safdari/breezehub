import 'package:breezehub/features/feature_weather/data/models/forecast_days_model.dart';
import 'package:equatable/equatable.dart';

class ForecastDaysEntity extends Equatable {
  final String? cod;
  final num? message;
  final num? cnt;
  final List<ListElement>? list;
  final City? city;

  const ForecastDaysEntity({this.cod, this.message, this.cnt, this.list, this.city});

  @override
  List<Object?> get props => [cod, message, cnt, list, city];
}
