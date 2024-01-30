import 'package:breezehub/core/params/params.dart';
import 'package:breezehub/core/resources/data_state.dart';
import 'package:breezehub/core/usecases/use_case.dart';
import 'package:breezehub/features/feature_weather/domain/entities/current_city_entity.dart';
import 'package:breezehub/features/feature_weather/domain/repositories/weather_repository.dart';

class GetWeatherMainDataUseCase extends UseCase<DataState<CurrentCityEntity>, LocationParams> {
  final WeatherRepository weatherRepository;

  GetWeatherMainDataUseCase(this.weatherRepository);

  @override
  Future<DataState<CurrentCityEntity>> call(LocationParams param) {
    return weatherRepository.getWeatherMainData(param);
  }
}
