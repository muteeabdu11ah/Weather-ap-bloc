part of 'weather_bloc.dart';

@immutable
sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

final class WeatherFailure extends WeatherState {
  final String message;

  WeatherFailure({required this.message});
}

final class WeatherSucess extends WeatherState {
  final WeatherModel weatherModel;

  WeatherSucess({required this.weatherModel});
}

final class WeatherLoading extends WeatherState {}


