import 'package:weather_app_bloc/secrets.dart';
import 'package:http/http.dart' as http;

class WeatherDataprovider {
  Future<String> getCurrentWeather(double lat, double lon) async {
    try {
      final res = await http.get(
        Uri.parse(
'https://api.openweathermap.org/data/3.0/onecall?lat=${lat}&lon=${lon}&appid=${openWeatherAPIKey}'        ),
      );
      return res.body;
    } catch (e) {
      throw e.toString();
    }
  }
}
