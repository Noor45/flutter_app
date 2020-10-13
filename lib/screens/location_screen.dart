import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({@required this.weatherLocation});
  final weatherLocation;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String city;
  int temperature;
  int condition;
  String weatherIcon;
  String weatherMsg;

  void initState() {
    updateWeather(widget.weatherLocation);
    super.initState();
  }

  WeatherModel weather = WeatherModel();

  void updateWeather(dynamic weatherInfo) async {
    setState(() {
      if (weatherInfo == null) {
        city = 'city';
        temperature = 0;
        weatherIcon = '🤷‍';
        weatherMsg = 'Unable to get weather data';
      }
      city = weatherInfo['name'];
      double temp = weatherInfo['main']['temp'];
      temperature = temp.toInt();
      condition = weatherInfo['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMsg = weather.getMessage(temperature);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background1.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: ()  {
                      setState(() async {
                        var locationWeather = await weather.getWeather();
                        updateWeather(locationWeather);
                      });

                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var textFeild = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if(textFeild != null){
                        // print(textFeild);
                        var cityWeather = await weather.getCityWeather(textFeild);
                        updateWeather(cityWeather);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherIcon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Text(
                  "$weatherMsg in $city!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
