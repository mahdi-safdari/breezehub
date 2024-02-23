import 'package:breezehub/features/feature_weather/domain/entities/forecast_days_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ForecastDaysStatus extends Equatable {}

class ForecastDaysLoading extends ForecastDaysStatus {
  @override
  List<Object?> get props => [];
}

class ForecastDaysCompleted extends ForecastDaysStatus {
  final ForecastDaysEntity daysEntity;
  ForecastDaysCompleted(this.daysEntity);

  @override
  List<Object?> get props => [daysEntity];
}

class ForecastDaysError extends ForecastDaysStatus {
  final String errorMessage;
  ForecastDaysError(this.errorMessage);

  @override
  List<Object?> get props => [];
}
