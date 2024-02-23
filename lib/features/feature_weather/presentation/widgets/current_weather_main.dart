import 'dart:ui';

import 'package:breezehub/core/params/location_params.dart';
import 'package:breezehub/core/utils/constants.dart';
import 'package:breezehub/core/utils/date_converter.dart';
import 'package:breezehub/features/feature_favorite/domain/entities/city_entity.dart';
import 'package:breezehub/features/feature_favorite/presentation/bloc/favorite_bloc.dart';
import 'package:breezehub/features/feature_favorite/presentation/bloc/get_city_status.dart';
import 'package:breezehub/features/feature_favorite/presentation/bloc/save_city_status.dart';
import 'package:breezehub/features/feature_weather/data/models/suggest_city_model.dart';
import 'package:breezehub/features/feature_weather/domain/entities/current_city_entity.dart';
import 'package:breezehub/features/feature_weather/domain/usecases/get_suggestion_city_usecase.dart';
import 'package:breezehub/features/feature_weather/presentation/bloc/home_bloc.dart';
import 'package:breezehub/features/feature_weather/presentation/bloc/main_data_status.dart';
import 'package:breezehub/service_locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gap/gap.dart';

class CurrentWeatherMain extends StatefulWidget {
  const CurrentWeatherMain({super.key});

  @override
  State<CurrentWeatherMain> createState() => _CurrentWeatherMainState();
}

class _CurrentWeatherMainState extends State<CurrentWeatherMain> {
  final TextEditingController textEditingController = TextEditingController();
  final GetSuggestionCityUseCase getSuggestionCityUseCase = GetSuggestionCityUseCase(locator());
  @override
  void initState() {
    super.initState();
    textEditingController.clear();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            // search field
            SizedBox(
              width: size.width * 0.75,
              height: size.height * 0.04,
              child: TypeAheadField(
                controller: textEditingController,
                loadingBuilder: (context) {
                  return const Center(child: CupertinoActivityIndicator());
                },
                decorationBuilder: (context, child) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Constants.quaternary),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
                        child: child,
                      ),
                    ),
                  );
                },
                builder: (context, controller, focusNode) {
                  return ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Constants.tertiary),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: controller,
                          focusNode: focusNode,
                          // onSubmitted: (String value) {
                          //   if (value.isNotEmpty) {
                          // TODO: BlocProvider.of<HomeBloc>(context).add(CurrentWeatherEvent(value));
                          //   }
                          // },
                          style: const TextStyle(color: Colors.white, fontSize: 17),
                          decoration: InputDecoration(
                            filled: true,
                            contentPadding: const EdgeInsets.all(0),
                            fillColor: Colors.transparent,
                            hintText: 'Search city',
                            hintStyle: TextStyle(color: const Color(0xffEBEBF5).withOpacity(0.6), fontSize: 17),
                            prefixIcon: Icon(CupertinoIcons.search, color: const Color(0xffEBEBF5).withOpacity(0.6), size: 17),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemBuilder: (BuildContext context, Data data) {
                  return ListTile(
                    title: Text(data.name!, style: theme.textTheme.labelLarge),
                    subtitle: Text('${data.region}, ${data.country}', style: theme.textTheme.bodyMedium),
                    leading: const Icon(CupertinoIcons.location_fill),
                  );
                },
                onSelected: (Data data) {
                  FocusScope.of(context).unfocus();
                  textEditingController.text = data.name!;
                  BlocProvider.of<HomeBloc>(context).add(MainDataEvent(LocationParams(lat: data.latitude!, lon: data.longitude!)));
                  // TODO: BlocProvider.of<HomeBloc>(context).add(CurrentWeatherEvent(data.city!));
                },
                suggestionsCallback: (String prefix) {
                  return getSuggestionCityUseCase(prefix);
                },
              ),
            ),
            // Current Weather Main
            BlocBuilder<HomeBloc, HomeState>(
              buildWhen: (HomeState previous, HomeState current) {
                if (previous.mainDataStatus == current.mainDataStatus) {
                  return false;
                } else {
                  return true;
                }
              },
              builder: (BuildContext context, HomeState state) {
                // Loading State
                if (state.mainDataStatus is MainDataEvent) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: CupertinoActivityIndicator(color: Constants.primary, radius: 20),
                    ),
                  );
                }

                // Completed State
                if (state.mainDataStatus is MainDataCompleted) {
                  final MainDataCompleted mainDataCompleted = state.mainDataStatus as MainDataCompleted;
                  final CurrentCityEntity currentCityEntity = mainDataCompleted.currentCityEntity;
                  final LocationParams locationParams = LocationParams(lat: currentCityEntity.coord!.lat!, lon: currentCityEntity.coord!.lon!);
                  BlocProvider.of<HomeBloc>(context).add(WeatherInformationEvent(locationParams));
                  BlocProvider.of<FavoriteBloc>(context).add(GetCityEvent(currentCityEntity.name!));
                  BlocProvider.of<HomeBloc>(context).add(ForecastDaysEvent(currentCityEntity.name!));
                  final String time = DateConverter.changeDtToDateTimeHourM(currentCityEntity.dt, currentCityEntity.timezone);
                  final CityEntity cityEntity = CityEntity(
                    lat: currentCityEntity.coord!.lat!.toDouble(),
                    lon: currentCityEntity.coord!.lon!.toDouble(),
                    name: currentCityEntity.name!,
                    description: currentCityEntity.weather![0].description!,
                    icon: currentCityEntity.weather![0].main!,
                    temp: currentCityEntity.main!.temp!.toDouble(),
                    tempMax: currentCityEntity.main!.tempMax!.toDouble(),
                    tempMin: currentCityEntity.main!.tempMin!.toDouble(),
                  );
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Gap(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FavoriteIcon(cityEntity: cityEntity),
                          Text(currentCityEntity.name!, style: theme.textTheme.displaySmall),
                          // const Gap(10),
                        ],
                      ),
                      Text('${currentCityEntity.main!.temp!.round()}\u00b0', style: theme.textTheme.displayLarge),
                      Text('update on: $time', style: theme.textTheme.titleMedium),
                      Text(currentCityEntity.weather![0].description!.toUpperCase(), style: theme.textTheme.titleLarge!.copyWith(color: Constants.primary)),
                    ],
                  );
                }

                // Error State
                if (state.mainDataStatus is MainDataError) {
                  final MainDataError mainError = state.mainDataStatus as MainDataError;
                  return Center(
                    child: Text(
                      mainError.message,
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  );
                }

                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FavoriteIcon extends StatelessWidget {
  final CityEntity cityEntity;
  const FavoriteIcon({super.key, required this.cityEntity});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      buildWhen: (previous, current) {
        // if state don't change => don't rebuild UI
        if (current.getCityStatus == previous.getCityStatus) {
          return false;
        }
        return true;
      },
      builder: (context, state) {
        BlocProvider.of<FavoriteBloc>(context).add(SaveCityInitialEvent());
        if (state.getCityStatus is GetCityCompleted) {
          final GetCityCompleted getCityCompleted = state.getCityStatus as GetCityCompleted;
          final CityEntity? city = getCityCompleted.cityEntity;

          return BlocConsumer<FavoriteBloc, FavoriteState>(
            listenWhen: (previous, current) {
              // if state don't change => don't listen to changes
              if (current.saveCityStatus == previous.saveCityStatus) {
                return false;
              }
              return true;
            },
            listener: (context, cityState) {
              // show Error as SnackBar
              if (cityState.saveCityStatus is SaveCityError) {
                // cast for getting Error
                final SaveCityError saveCityError = cityState.saveCityStatus as SaveCityError;

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    backgroundColor: Colors.redAccent.withOpacity(0.9),
                    content: Text(
                      saveCityError.message,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }

              // show Success SnackBar
              if (cityState.saveCityStatus is SaveCityCompleted) {
                // cast for getting Data
                final SaveCityCompleted saveCityCompleted = cityState.saveCityStatus as SaveCityCompleted;

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    backgroundColor: Colors.greenAccent.withOpacity(0.9),
                    content: Text(
                      "${saveCityCompleted.cityEntity.name} Added to Bookmark",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            buildWhen: (previous, current) {
              if (previous.saveCityStatus == current.saveCityStatus) {
                return false;
              } else {
                return true;
              }
            },
            builder: (context, state) {
              if (state.saveCityStatus is SaveCityInitial) {
                return IconButton(
                  onPressed: () {
                    BlocProvider.of<FavoriteBloc>(context).add(SaveCityEvent(cityEntity));
                    // if (city != null) {
                    //   BlocProvider.of<FavoriteBloc>(context).add(DeleteCityEvent(city.name));
                    //   print('@@@@@@@@@@@@@@@@@@@@@@@@@@');
                    // }
                  },
                  icon: city == null ? const Icon(CupertinoIcons.bookmark, color: Colors.white, size: 28) : const Icon(CupertinoIcons.bookmark_fill, color: Colors.white, size: 28),
                );
              }
              return IconButton(
                onPressed: () {
                  // call event for save Current City in Database
                  BlocProvider.of<FavoriteBloc>(context).add(SaveCityEvent(cityEntity));
                  print('>>>>>>>>>>>>>>>>>>>');
                },
                icon: const Icon(CupertinoIcons.bookmark_fill, color: Colors.white, size: 28),
              );
            },
          );
        }
        return Container();
      },
    );
  }
}
