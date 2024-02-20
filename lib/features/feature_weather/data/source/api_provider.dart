import 'package:breezehub/core/params/location_params.dart';
import 'package:breezehub/core/utils/constants.dart';
import 'package:dio/dio.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String apiKey = Constants.apiKey;
  final String apiKey2 = Constants.apiKey2;
  final String baseUrl = Constants.baseUrl;

  Future<Response> getMainData(LocationParams params) async {
    final Response response = await _dio.get(
      '$baseUrl/data/2.5/weather',
      queryParameters: {
        'lat': params.lat,
        'lon': params.lon,
        'appid': apiKey,
        'units': 'metric',
      },
    );
    return response;
  }

  Future<Response> callCurrentWeather(String cityName) async {
    final Response response = await _dio.get(
      '$baseUrl/data/2.5/weather',
      queryParameters: {
        'q': cityName,
        'appid': apiKey,
        'units': 'metric',
        // 'lang': 'fa',
      },
    );
    return response;
  }

  Future<Response> callForecast5DaysWeather(String cityName) async {
    final Response response = await _dio.get(
      '$baseUrl/data/2.5/forecast',
      queryParameters: {
        'q': cityName,
        'appid': apiKey,
        'units': 'metric',
      },
    );
    return response;
  }

  Future<Response> callWeatherInformation(LocationParams params) async {
    final Response response = await _dio.get(
      '$baseUrl/data/2.5/onecall',
      queryParameters: {
        'lat': params.lat,
        'lon': params.lon,
        'units': 'metric',
        'appid': apiKey2,
      },
    );
    return response;
  }

  Future<Response> sendRequestCitySuggestion(String prefix) async {
    final Response response = await _dio.get(
      'http://geodb-free-service.wirefreethought.com/v1/geo/cities',
      queryParameters: {
        'limit': 7,
        'offset': 0,
        'namePrefix': prefix,
        // 'sort': 'name',
      },
    );
    return response;
  }
}
