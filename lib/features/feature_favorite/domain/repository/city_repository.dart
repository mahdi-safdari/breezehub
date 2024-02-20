import 'package:breezehub/core/resources/data_state.dart';
import 'package:breezehub/features/feature_favorite/domain/entities/city_entity.dart';

abstract class CityRepository {
  Future<DataState<CityEntity>> saveCity(CityEntity cityEntity);
  Future<DataState<List<CityEntity>>> getAllCity();
  Future<DataState<CityEntity?>> findCityByName(String name);
  Future<DataState<String>> deleteCityByName(String name);
}
