import 'package:breezehub/core/params/location_params.dart';
import 'package:breezehub/core/resources/data_state.dart';
import 'package:breezehub/features/feature_weather/data/models/suggest_city_model.dart';
import 'package:breezehub/features/feature_weather/domain/entities/current_city_entity.dart';
import 'package:breezehub/features/feature_weather/domain/entities/forecast_days_entity.dart';
import 'package:breezehub/features/feature_weather/domain/entities/weather_information_entity.dart';

abstract class WeatherRepository {
  Future<DataState<CurrentCityEntity>> fetchCurrentWeatherData(String cityName);
  Future<DataState<ForecastDaysEntity>> fetchForecastDaysData(String cityName);
  Future<DataState<WeatherInformationEntity>> fetchWeatherInformationData(LocationParams params);
  Future<List<Data>> fetchSuggestData(String prefix);
  Future<DataState<CurrentCityEntity>> getMainData(LocationParams params);
}
