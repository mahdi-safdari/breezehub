import 'package:breezehub/core/params/location_params.dart';
import 'package:breezehub/core/resources/data_state.dart';
import 'package:breezehub/features/feature_weather/data/models/current_city_model.dart';
import 'package:breezehub/features/feature_weather/data/models/forecast_days_model.dart';
import 'package:breezehub/features/feature_weather/data/models/suggest_city_model.dart';
import 'package:breezehub/features/feature_weather/data/models/weather_information_model.dart';
import 'package:breezehub/features/feature_weather/data/source/api_provider.dart';
import 'package:breezehub/features/feature_weather/domain/entities/current_city_entity.dart';
import 'package:breezehub/features/feature_weather/domain/entities/forecast_days_entity.dart';
import 'package:breezehub/features/feature_weather/domain/entities/suggest_city_entity.dart';
import 'package:breezehub/features/feature_weather/domain/entities/weather_information_entity.dart';
import 'package:breezehub/features/feature_weather/domain/repositories/weather_repository.dart';
import 'package:dio/dio.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final ApiProvider apiProvider;
  WeatherRepositoryImpl(this.apiProvider);

  @override
  Future<DataState<CurrentCityEntity>> fetchCurrentWeatherData(String cityName) async {
    try {
      final Response response = await apiProvider.callCurrentWeather(cityName);
      if (response.statusCode == 200) {
        final CurrentCityEntity cityEntity = CurrentCityModel.fromJson(response.data);

        return DataSuccess(cityEntity);
      } else {
        return DataFailed('Something went wrong try again ...');
      }
    } on DioException catch (dioError) {
      if (dioError.response?.statusCode == 404) {
        return DataFailed('City not found');
      }
      return DataFailed('Please check your connection ...');
    }
  }

  @override
  Future<DataState<ForecastDaysEntity>> fetchForecastDaysData(String cityName) async {
    try {
      final Response response = await apiProvider.callForecast5DaysWeather(cityName);
      if (response.statusCode == 200) {
        final ForecastDaysEntity forecastDaysEntity = ForecastDaysModel.fromJson(response.data);
        return DataSuccess(forecastDaysEntity);
      } else {
        return DataFailed('Something went wrong try again ...');
      }
    } catch (e) {
      return DataFailed('Please check your connection ...');
    }
  }

  @override
  Future<DataState<WeatherInformationEntity>> fetchWeatherInformationData(LocationParams params) async {
    try {
      final Response response = await apiProvider.callWeatherInformation(params);
      if (response.statusCode == 200) {
        final WeatherInformationEntity informationEntity = WeatherInformationModel.fromJson(response.data);
        return DataSuccess(informationEntity);
      } else {
        return DataFailed('Something went wrong try again ...');
      }
    } catch (e) {
      return DataFailed('Please check your connection ...');
    }
  }

  @override
  Future<List<Data>> fetchSuggestData(String prefix) async {
    try {
      final Response response = await apiProvider.sendRequestCitySuggestion(prefix);
      final SuggestCityEntity suggestCityEntity = SuggestCityModel.fromJson(response.data);
      return suggestCityEntity.data!;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<DataState<CurrentCityEntity>> getMainData(LocationParams params) async {
    try {
      final Response response = await apiProvider.getMainData(params);
      if (response.statusCode == 200) {
        CurrentCityEntity currentCityEntity = CurrentCityModel.fromJson(response.data);
        return DataSuccess(currentCityEntity);
      } else {
        return DataFailed('Something went wrong try again ...');
      }
    } catch (e) {
      return DataFailed('Please check your connection...');
    }
  }
}
