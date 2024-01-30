import 'package:breezehub/core/resources/data_state.dart';
import 'package:breezehub/core/usecases/use_case.dart';
import 'package:breezehub/features/feature_weather/domain/entities/forecast_days_entity.dart';
import 'package:breezehub/features/feature_weather/domain/repositories/weather_repository.dart';

class ForecastDaysUseCase extends UseCase<DataState<ForecastDaysEntity>, String> {
  final WeatherRepository weatherRepository;

  ForecastDaysUseCase(this.weatherRepository);

  @override
  Future<DataState<ForecastDaysEntity>> call(String param) {
    return weatherRepository.fetchForecastDaysData(param);
  }
}
