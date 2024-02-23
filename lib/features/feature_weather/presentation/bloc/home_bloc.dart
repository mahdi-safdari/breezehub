import 'package:bloc/bloc.dart';
import 'package:breezehub/core/params/location_params.dart';
import 'package:breezehub/core/resources/data_state.dart';
import 'package:breezehub/features/feature_weather/domain/usecases/get_current_weather_usecase.dart';
import 'package:breezehub/features/feature_weather/domain/usecases/get_forecast_days_usecase.dart';
import 'package:breezehub/features/feature_weather/domain/usecases/get_main_data_usecase.dart';
import 'package:breezehub/features/feature_weather/domain/usecases/get_weather_information_usecase.dart';
import 'package:breezehub/features/feature_weather/presentation/bloc/current_weather_status.dart';
import 'package:breezehub/features/feature_weather/presentation/bloc/forecast_days_status.dart';
import 'package:breezehub/features/feature_weather/presentation/bloc/main_data_status.dart';
import 'package:breezehub/features/feature_weather/presentation/bloc/weather_information_status.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  final GetForecastDaysUseCase getForecastDaysUseCase;
  final GetWeatherInformationUseCase getWeatherInformationUseCase;
  final GetMainDataUseCase getMainDataUseCase;
  HomeBloc(
    this.getCurrentWeatherUseCase,
    this.getForecastDaysUseCase,
    this.getWeatherInformationUseCase,
    this.getMainDataUseCase,
  ) : super(
          HomeState(
            currentWeatherStatus: CurrentWeatherLoading(),
            forecastDaysStatus: ForecastDaysLoading(),
            informationStatus: WeatherInformationLoading(),
            mainDataStatus: MainDataLoading(),
          ),
        ) {
    on<CurrentWeatherEvent>((CurrentWeatherEvent event, Emitter<HomeState> emit) async {
      emit(state.copyWith(currentWeatherStatus: CurrentWeatherLoading()));

      final DataState dataState = await getCurrentWeatherUseCase(event.cityName);
      if (dataState is DataSuccess) {
        emit(state.copyWith(currentWeatherStatus: CurrentWeatherCompleted(dataState.data)));
      }

      if (dataState is DataFailed) {
        emit(state.copyWith(currentWeatherStatus: CurrentWeatherError(dataState.errorMessage!)));
      }
    });

    on<ForecastDaysEvent>((ForecastDaysEvent event, Emitter<HomeState> emit) async {
      emit(state.copyWith(forecastDaysStatus: ForecastDaysLoading()));
      final DataState dataState = await getForecastDaysUseCase(event.cityName);
      if (dataState is DataSuccess) {
        emit(state.copyWith(forecastDaysStatus: ForecastDaysCompleted(dataState.data)));
      }
      if (dataState is DataFailed) {
        emit(state.copyWith(forecastDaysStatus: ForecastDaysError(dataState.errorMessage!)));
      }
    });

    on<WeatherInformationEvent>((WeatherInformationEvent event, Emitter<HomeState> emit) async {
      emit(state.copyWith(informationStatus: WeatherInformationLoading()));
      final DataState dataState = await getWeatherInformationUseCase(event.locationParams);
      if (dataState is DataSuccess) {
        emit(state.copyWith(informationStatus: WeatherInformationCompleted(dataState.data)));
      }
      if (dataState is DataFailed) {
        emit(state.copyWith(informationStatus: WeatherInformationError(dataState.errorMessage!)));
      }
    });

    on<MainDataEvent>((MainDataEvent event, Emitter<HomeState> emit) async {
      emit(state.copyWith(mainDataStatus: MainDataLoading()));
      final DataState dataState = await getMainDataUseCase(event.params);
      if (dataState is DataSuccess) {
        if (!isClosed) {
          emit(state.copyWith(mainDataStatus: MainDataCompleted(dataState.data)));
        }
      }

      if (dataState is DataFailed) {
        emit(state.copyWith(mainDataStatus: MainDataError(dataState.errorMessage!)));
      }
    });
  }
}
