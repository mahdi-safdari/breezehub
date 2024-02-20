import 'package:breezehub/features/feature_weather/data/models/suggest_city_model.dart';
import 'package:equatable/equatable.dart';

class SuggestCityEntity extends Equatable {
  final List<Data>? data;
  final Metadata? metadata;

  const SuggestCityEntity({required this.data, required this.metadata});

  @override
  List<Object?> get props => [data, metadata];
}
