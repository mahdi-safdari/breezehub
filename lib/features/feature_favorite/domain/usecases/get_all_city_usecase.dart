import 'package:breezehub/core/resources/data_state.dart';
import 'package:breezehub/core/usecases/use_case.dart';
import 'package:breezehub/features/feature_favorite/domain/entities/city_entity.dart';
import 'package:breezehub/features/feature_favorite/domain/repository/city_repository.dart';

class GetAllCityUseCase extends UseCase<DataState<List<CityEntity>>, Null> {
  final CityRepository cityRepository;
  GetAllCityUseCase(this.cityRepository);

  @override
  Future<DataState<List<CityEntity>>> call(Null param) {
    return cityRepository.getAllCity();
  }
}
