import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:weather_app_bloc/data/repository/weather_repository.dart';
import 'package:weather_app_bloc/models/weather_model.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc(this.weatherRepository) : super(WeatherInitial()) {
    on<WeatherFetched>(_getCurrentWeather);
  }

  void _getCurrentWeather(
      WeatherEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium);
      print(position);
      final weather = await weatherRepository.getCurrentWeather(
          position.latitude, position.longitude);
      print(weather);

      weather.fold((l) {
        emit(WeatherFailure(message: 'an error accoured'));
      }, (r) {
        emit(WeatherSucess(weatherModel: r));
      });
    } on Exception catch (e) {
      emit(WeatherFailure(message: e.toString()));
    }
  }
}
