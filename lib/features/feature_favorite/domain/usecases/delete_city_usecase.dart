import 'package:breezehub/core/resources/data_state.dart';
import 'package:breezehub/core/usecases/use_case.dart';
import 'package:breezehub/features/feature_favorite/domain/repository/city_repository.dart';

class DeleteCityUseCase extends UseCase<DataState<String>, String> {
  final CityRepository cityRepository;
  DeleteCityUseCase(this.cityRepository);

  @override
  Future<DataState<String>> call(String param) {
    return cityRepository.deleteCityByName(param);
  }
}
