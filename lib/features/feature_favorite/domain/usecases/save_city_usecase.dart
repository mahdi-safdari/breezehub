import 'package:breezehub/core/resources/data_state.dart';
import 'package:breezehub/core/usecases/use_case.dart';
import 'package:breezehub/features/feature_favorite/domain/entities/city_entity.dart';
import 'package:breezehub/features/feature_favorite/domain/repository/city_repository.dart';

class SaveCityUseCase extends UseCase<DataState<CityEntity>, CityEntity> {
  final CityRepository cityRepository;
  SaveCityUseCase(this.cityRepository);

  @override
  Future<DataState<CityEntity>> call(CityEntity param) {
    return cityRepository.saveCity(param);
  }
}
