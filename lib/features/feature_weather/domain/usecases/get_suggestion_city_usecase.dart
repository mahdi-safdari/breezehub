import 'package:breezehub/core/usecases/use_case.dart';
import 'package:breezehub/features/feature_weather/data/models/suggest_city_model.dart';
import 'package:breezehub/features/feature_weather/domain/repositories/weather_repository.dart';

class GetSuggestionCityUseCase extends UseCase<List<Data>, String> {
  final WeatherRepository weatherRepository;
  GetSuggestionCityUseCase(this.weatherRepository);

  @override
  Future<List<Data>> call(String param) {
    return weatherRepository.fetchSuggestData(param);
  }
}
