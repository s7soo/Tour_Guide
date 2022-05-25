import 'package:flutter/material.dart';
import 'package:tour_guide/General_Page/components/Scaffold_menu.dart';
import 'package:tour_guide/weather_screen/screens/city_screen.dart';
import 'package:tour_guide/General_Page/components/constants.dart';
import 'package:tour_guide/weather_screen/components/weather.dart';


class LocationScreen extends StatefulWidget {

  LocationScreen({this.LocationWeaherData});

  final LocationWeaherData;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  WeatherModel weatherModelObject = WeatherModel();
  late int temperature;
  late String conditionIcon;
  late String cityName;
  late String tempMessage;

  @override
  void initState() {
    super.initState();
    updateUi(widget.LocationWeaherData);
  }

  void updateUi(dynamic weatherData){
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        cityName = '';
        conditionIcon = 'Error';
        tempMessage = 'Error Can\'t find your location';
        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      var condition = weatherData['weather'][0]['id'];
      cityName = weatherData['name'];
      conditionIcon = weatherModelObject.getWeatherIcon(condition);
      tempMessage = weatherModelObject.getMessage(temperature);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMenu(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
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
                    onPressed: () async {
                      int count = 0;
                      Navigator.popUntil(context, (route) {
                        return count++ == 2;
                      });
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                          context, MaterialPageRoute(
                          builder: (context){
                        return CityScreen();
                      }),);
                      if (typedName != null) {
                       var weatherData =  await weatherModelObject.getCityWeather(typedName);
                       updateUi(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await weatherModelObject.getLocationWeather();
                      updateUi(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
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
                      '$conditionIcon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$tempMessage in $cityName",
                  textAlign: TextAlign.left,
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


//
// var longitude = jsonDecoded['coord']['lon'];
// var latitude = jsonDecoded['coord']['lat'];
// var weatherDescription = jsonDecoded['weather'][0]['description'];