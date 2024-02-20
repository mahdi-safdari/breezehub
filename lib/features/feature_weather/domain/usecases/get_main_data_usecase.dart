import 'package:breezehub/core/params/location_params.dart';
import 'package:breezehub/core/resources/data_state.dart';
import 'package:breezehub/core/usecases/use_case.dart';
import 'package:breezehub/features/feature_weather/domain/entities/current_city_entity.dart';
import 'package:breezehub/features/feature_weather/domain/repositories/weather_repository.dart';

class GetMainDataUseCase extends UseCase<DataState<CurrentCityEntity>, LocationParams> {
  final WeatherRepository weatherRepository;

  GetMainDataUseCase(this.weatherRepository);

  @override
  Future<DataState<CurrentCityEntity>> call(LocationParams param) {
    return weatherRepository.getMainData(param);
  }
}
