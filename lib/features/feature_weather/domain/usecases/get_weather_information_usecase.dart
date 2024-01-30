import 'package:breezehub/core/params/params.dart';
import 'package:breezehub/core/resources/data_state.dart';
import 'package:breezehub/core/usecases/use_case.dart';
import 'package:breezehub/features/feature_weather/domain/entities/weather_information_entity.dart';
import 'package:breezehub/features/feature_weather/domain/repositories/weather_repository.dart';

class GetWeatherInformation extends UseCase<DataState<WeatherInformationEntity>, LocationParams> {
  final WeatherRepository weatherRepository;
  GetWeatherInformation(this.weatherRepository);

  @override
  Future<DataState<WeatherInformationEntity>> call(LocationParams param) {
    return weatherRepository.fetchWeatherInformationData(param);
  }
}
