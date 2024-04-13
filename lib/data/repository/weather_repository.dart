import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:weather_app_bloc/data/data_provider/weather_data_provider.dart';
import 'package:weather_app_bloc/models/weather_model.dart';
import 'package:weather_app_bloc/secrets.dart';
import 'package:http/http.dart' as http;

class WeatherRepository {
  final WeatherDataprovider weatherDataprovider;

  WeatherRepository(this.weatherDataprovider);
  Future<WeatherModel> getCurrentWeather(double lat, double lon) async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium);
      print('p $position');
      final weahterdata = await weatherDataprovider.getCurrentWeather(
          position.latitude, position.longitude);
      final daata = jsonDecode(weahterdata);
      print(daata);

      if (daata['cod'] != 200) {
        throw 'an unexpected error happened';
      }

      return daata;
    } catch (e) {
      throw e.toString();
    }
  }
}
