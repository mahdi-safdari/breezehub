import 'package:breezehub/core/utils/theme.dart';
import 'package:breezehub/features/feature_favorite/presentation/bloc/favorite_bloc.dart';
import 'package:breezehub/features/feature_favorite/presentation/screens/favorite_page.dart';
import 'package:breezehub/features/feature_weather/presentation/bloc/cubit/change_stack_cubit.dart';
import 'package:breezehub/features/feature_weather/presentation/bloc/home_bloc.dart';
import 'package:breezehub/features/feature_weather/presentation/screens/home_screen.dart';
import 'package:breezehub/features/feature_weather/presentation/screens/splash_screen.dart';
import 'package:breezehub/features/feature_weather/presentation/screens/thorough_forecast_screen.dart';
import 'package:breezehub/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(create: (_) => locator<HomeBloc>()),
        BlocProvider<ChangeStackCubit>(create: (_) => ChangeStackCubit()),
        BlocProvider<FavoriteBloc>(create: (_) => locator<FavoriteBloc>()),
      ],
      child: MaterialApp.router(
        title: 'BreezeHub',
        debugShowCheckedModeBanner: false,
        theme: MyThemeData.myTheme,
        routerConfig: GoRouter(
          routes: [
            GoRoute(
              path: SplashScreen.routeName,
              builder: (context, state) {
                return const SplashScreen();
              },
            ),
            GoRoute(
              path: HomeScreen.routeName,
              builder: (context, state) {
                return const HomeScreen();
              },
            ),
            GoRoute(
              path: FavoritePage.routeName,
              builder: (context, state) {
                return const FavoritePage();
              },
            ),
            GoRoute(
              path: ThoroughForecastScreen.routeName,
              builder: (context, state) {
                return const ThoroughForecastScreen();
              },
            ),
          ],
        ),
      ),
    );
  }
}
