import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const key = '77200ebbb471e2461868e3969c69b239';

class WeatherModel {
  var getData;
  var getData_;

  Future<dynamic> getCityWeather(dynamic city) async {
    Networking location = await Networking('http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$key&units=metric');
    getData_ = await location.getData();
    return getData_;
  }

  Future<dynamic> getWeather() async {
    Location newLocation = Location();
    await newLocation.getCurrentLocation();
    Networking location = await Networking('http://api.openweathermap.org/data/2.5/weather?lat=${newLocation.latitude}&lon=${newLocation.longitude}&appid=$key&units=metric');
    getData = await location.getData();
    return getData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
