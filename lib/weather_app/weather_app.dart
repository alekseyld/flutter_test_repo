import 'package:bloc/bloc.dart';
import 'package:bloctestapp/weather_app/blocs/bloc.dart';
import 'package:bloctestapp/weather_app/repositories/repositories.dart';
import 'package:bloctestapp/weather_app/simple_bloc_delegate.dart';
import 'package:bloctestapp/weather_app/widgets/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

void runWeatherApp() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  final WeatherRepository weatherRepository = WeatherRepository(
    weatherApiClient: WeatherApiClient(
      httpClient: http.Client(),
    ),
  );

  runApp(
    BlocProvider<ThemeBloc>(
      create: (context) => ThemeBloc(),
      child: WeatherApp(weatherRepository: weatherRepository),
    ),
  );
}

class WeatherApp extends StatelessWidget {
  final WeatherRepository weatherRepository;

  WeatherApp({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      return MaterialApp(
        title: 'Flutter Weather',
        theme: themeState.theme,
        home: BlocProvider(
          create: (context) =>
              WeatherBloc(weatherRepository: weatherRepository),
          child: Weather(),
        ),
      );
    });
  }
}
