import 'package:breezehub/features/feature_favorite/data/repository/city_repository_impl.dart';
import 'package:breezehub/features/feature_favorite/data/source/database.dart';
import 'package:breezehub/features/feature_favorite/domain/repository/city_repository.dart';
import 'package:breezehub/features/feature_favorite/domain/usecases/delete_city_usecase.dart';
import 'package:breezehub/features/feature_favorite/domain/usecases/get_all_city_usecase.dart';
import 'package:breezehub/features/feature_favorite/domain/usecases/get_city_usecase.dart';
import 'package:breezehub/features/feature_favorite/domain/usecases/save_city_usecase.dart';
import 'package:breezehub/features/feature_favorite/presentation/bloc/favorite_bloc.dart';
import 'package:breezehub/features/feature_weather/data/repositories/weather_repository_impl.dart';
import 'package:breezehub/features/feature_weather/data/source/api_provider.dart';
import 'package:breezehub/features/feature_weather/domain/repositories/weather_repository.dart';
import 'package:breezehub/features/feature_weather/domain/usecases/get_current_weather_usecase.dart';
import 'package:breezehub/features/feature_weather/domain/usecases/get_forecast_days_usecase.dart';
import 'package:breezehub/features/feature_weather/domain/usecases/get_main_data_usecase.dart';
import 'package:breezehub/features/feature_weather/domain/usecases/get_weather_information_usecase.dart';
import 'package:breezehub/features/feature_weather/presentation/bloc/home_bloc.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

setUpLocator() async {
  // Favorite feature
  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  locator.registerSingleton<AppDatabase>(database);
  locator.registerSingleton<CityRepository>(CityRepositoryImpl(database.cityDao));
  locator.registerSingleton<SaveCityUseCase>(SaveCityUseCase(locator()));
  locator.registerSingleton<GetAllCityUseCase>(GetAllCityUseCase(locator()));
  locator.registerSingleton<DeleteCityUseCase>(DeleteCityUseCase(locator()));
  locator.registerSingleton<GetCityUseCase>(GetCityUseCase(locator()));
  locator.registerSingleton<FavoriteBloc>(FavoriteBloc(locator(), locator(), locator(), locator()));
  // Weather feature
  locator.registerSingleton<ApiProvider>(ApiProvider());
  locator.registerSingleton<WeatherRepository>(WeatherRepositoryImpl(locator()));
  locator.registerSingleton<GetCurrentWeatherUseCase>(GetCurrentWeatherUseCase(locator()));
  locator.registerSingleton<GetForecastDaysUseCase>(GetForecastDaysUseCase(locator()));
  locator.registerSingleton<GetWeatherInformationUseCase>(GetWeatherInformationUseCase(locator()));
  locator.registerSingleton<GetMainDataUseCase>(GetMainDataUseCase(locator()));
  locator.registerSingleton<HomeBloc>(HomeBloc(locator(), locator(), locator(), locator()));
}
