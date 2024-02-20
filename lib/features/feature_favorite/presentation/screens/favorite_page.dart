import 'package:breezehub/core/assets.dart';
import 'package:breezehub/core/params/location_params.dart';
import 'package:breezehub/core/utils/constants.dart';
import 'package:breezehub/core/widgets/get_weather_icon.dart';
import 'package:breezehub/features/feature_favorite/domain/entities/city_entity.dart';
import 'package:breezehub/features/feature_favorite/presentation/bloc/delete_city_status.dart';
import 'package:breezehub/features/feature_favorite/presentation/bloc/favorite_bloc.dart';
import 'package:breezehub/features/feature_favorite/presentation/bloc/get_all_city_status.dart';
import 'package:breezehub/features/feature_weather/presentation/bloc/home_bloc.dart';
import 'package:breezehub/features/feature_weather/presentation/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class FavoritePage extends StatefulWidget {
  static const String routeName = '/favorite';
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<FavoriteBloc>(context).add(GetAllCityEvent());
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xff2E335A),
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            const Gap(8),
            GestureDetector(
              onTap: () {
                context.pop();
              },
              child: SvgPicture.asset(Assets.chevronLeft, width: 18, height: 24),
            ),
            const Gap(16),
            Text('Favorite', style: theme.textTheme.headlineSmall),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(CupertinoIcons.ellipsis_vertical, color: Constants.primary),
          ),
        ],
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Container(
              width: 300,
              height: 300,
              decoration: ShapeDecoration(shape: const OvalBorder(), shadows: [
                BoxShadow(
                  color: const Color(0xff612FAB).withOpacity(0.3),
                  spreadRadius: 0,
                  blurRadius: 100,
                ),
              ]),
            ),
            Positioned(
              bottom: 50,
              right: 0,
              child: Container(
                width: 300,
                height: 300,
                decoration: ShapeDecoration(shape: const OvalBorder(), shadows: [
                  BoxShadow(
                    color: const Color(0xff612FAB).withOpacity(0.3),
                    spreadRadius: 0,
                    blurRadius: 100,
                  ),
                ]),
              ),
            ),
            SizedBox(
              height: size.height,
              width: size.width,
              child: BlocConsumer<FavoriteBloc, FavoriteState>(
                buildWhen: (previous, current) {
                  if (previous.getAllCityStatus == current.getAllCityStatus && previous.deleteCityStatus == current.deleteCityStatus) {
                    return false;
                  } else {
                    return true;
                  }
                },
                builder: (BuildContext context, FavoriteState state) {
                  if (state.getAllCityStatus is GetAllCityCompleted) {
                    final GetAllCityCompleted getAllCityCompleted = state.getAllCityStatus as GetAllCityCompleted;
                    final List<CityEntity> cities = getAllCityCompleted.allCity;

                    return cities.isNotEmpty
                        ? ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: cities.length,
                            padding: const EdgeInsets.only(top: 27),
                            itemBuilder: (BuildContext context, int index) {
                              final CityEntity city = cities[index];
                              final LocationParams locationParams = LocationParams(lat: city.lat, lon: city.lon);
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 30),
                                child: Dismissible(
                                  key: Key(city.name),
                                  onDismissed: (direction) {
                                    cities.removeAt(index);
                                    BlocProvider.of<FavoriteBloc>(context).add(DeleteCityEvent(city.name));
                                    BlocProvider.of<FavoriteBloc>(context).add(SaveCityInitialEvent());
                                  },
                                  child: SizedBox(
                                    height: 184,
                                    width: 342,
                                    child: GestureDetector(
                                      onTap: () {
                                        BlocProvider.of<HomeBloc>(context).add(MainDataEvent(locationParams));
                                        context.go(HomeScreen.routeName);
                                      },
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        alignment: Alignment.center,
                                        children: [
                                          SvgPicture.asset(Assets.regtangle1),
                                          Positioned(
                                            right: 60,
                                            bottom: 60,
                                            child: SizedBox(width: 100, height: 100, child: GetWeatherIcon.getIcon(city.icon)),
                                          ),
                                          Positioned(
                                            left: 60,
                                            bottom: 25,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  '${city.temp.round()}°',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 64,
                                                    fontWeight: FontWeight.w400,
                                                    height: 0.01,
                                                    letterSpacing: 0.37,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 40),
                                                  child: Row(
                                                    children: [
                                                      Text('H:${city.tempMax.round()}\u00b0', style: theme.textTheme.labelMedium!.apply(fontSizeFactor: 1.1)),
                                                      const Gap(8),
                                                      Text('L:${city.tempMin.round()}\u00b0', style: theme.textTheme.labelMedium!.apply(fontSizeFactor: 1.1)),
                                                    ],
                                                  ),
                                                ),
                                                Text(city.name, style: theme.textTheme.titleMedium!.apply(color: Constants.primary)),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 25,
                                            right: 60,
                                            child: Text(city.description, style: theme.textTheme.titleSmall),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : Container(
                            width: size.width,
                            height: size.height,
                            color: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(Assets.noData, width: 200, height: 200),
                                const Gap(20),
                                Text(
                                  'No city has been selected',
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                          );
                  }
                  return Container();
                },
                listenWhen: (previous, current) {
                  if (previous.deleteCityStatus == current.deleteCityStatus) {
                    return false;
                  } else {
                    return true;
                  }
                },
                listener: (BuildContext context, FavoriteState state) {
                  if (state.deleteCityStatus is DeleteCityCompleted) {
                    DeleteCityCompleted deleteCityCompleted = state.deleteCityStatus as DeleteCityCompleted;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        width: size.width * 0.5,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        backgroundColor: Colors.amber.withOpacity(0.9),
                        content: Center(
                          child: Text(
                            "${deleteCityCompleted.name} was removed",
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),
                          ),
                        ),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
