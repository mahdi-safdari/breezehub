import 'package:breezehub/core/resources/data_state.dart';
import 'package:breezehub/core/usecases/use_case.dart';
import 'package:breezehub/features/feature_favorite/domain/entities/city_entity.dart';
import 'package:breezehub/features/feature_favorite/domain/repository/city_repository.dart';

class GetCityUseCase extends UseCase<DataState<CityEntity?>, String> {
  final CityRepository cityRepository;
  GetCityUseCase(this.cityRepository);

  @override
  Future<DataState<CityEntity?>> call(String param) {
    return cityRepository.findCityByName(param);
  }
}
