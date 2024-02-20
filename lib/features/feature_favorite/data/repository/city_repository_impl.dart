import 'package:breezehub/core/resources/data_state.dart';
import 'package:breezehub/features/feature_favorite/data/source/city_dao.dart';
import 'package:breezehub/features/feature_favorite/domain/entities/city_entity.dart';
import 'package:breezehub/features/feature_favorite/domain/repository/city_repository.dart';

class CityRepositoryImpl extends CityRepository {
  final CityDao cityDao;
  CityRepositoryImpl(this.cityDao);

  @override
  Future<DataState<String>> deleteCityByName(String name) async {
    try {
      await cityDao.deleteCityByName(name);
      return DataSuccess(name);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<CityEntity?>> findCityByName(String name) async {
    try {
      final CityEntity? cityEntity = await cityDao.findCityByName(name);
      return DataSuccess(cityEntity);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<List<CityEntity>>> getAllCity() async {
    try {
      final List<CityEntity> allCityEntity = await cityDao.getAllCity();
      return DataSuccess(allCityEntity);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<CityEntity>> saveCity(CityEntity cityEntity) async {
    try {
      final CityEntity? checkCity = await cityDao.findCityByName(cityEntity.name);
      if (checkCity != null) {
        return DataFailed('${cityEntity.name} has already existed');
      }
      // CityEntity cityEntity = cityModel;
      await cityDao.insertCity(cityEntity);
      return DataSuccess(cityEntity);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
}
