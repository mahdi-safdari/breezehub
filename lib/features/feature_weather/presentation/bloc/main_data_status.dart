import 'package:breezehub/features/feature_weather/domain/entities/current_city_entity.dart';
import 'package:equatable/equatable.dart';

abstract class MainDataStatus extends Equatable {}

class MainDataLoading extends MainDataStatus {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class MainDataCompleted extends MainDataStatus {
  final CurrentCityEntity currentCityEntity;

  MainDataCompleted(this.currentCityEntity);

  @override
  // TODO: implement props
  List<Object?> get props => [currentCityEntity];
}

class MainDataError extends MainDataStatus {
  final String message;

  MainDataError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
