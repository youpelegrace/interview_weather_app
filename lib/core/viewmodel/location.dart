import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/core/models/get_weather.dart';


class LocationProvider extends ChangeNotifier{
    double? _currentLatitude;
    double? _currentLongitude;
    GetWeather? _weatherData;

   double? get currentLatitude=> _currentLatitude;
   double? get currentLongitude=> _currentLongitude;
   GetWeather? get weatherData=> _weatherData;

  Future getUserLocation() async{
  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);

  
  _currentLongitude = position.longitude;
  _currentLatitude = position.latitude;
  if(_currentLatitude == null || _currentLongitude == null){
    return;
    //handle a notification saying no location
  } 
final _result = await getWeatherData(currentLatitude: _currentLatitude!, currentLongitude: _currentLongitude!);
_weatherData = _result;
notifyListeners();
  
  }   

  Future<GetWeather> getWeatherData({required double currentLatitude, required double currentLongitude}) async{
     final response = await http.get(
      Uri.parse("https://api.openweathermap.org/data/2.5/forecast/daily?lat=$currentLatitude&lon=$currentLongitude&appid=542ffd081e67f4512b705f89d2a611b2&cnt=5"));
      final _getWeather = getWeatherFromJson(response.body); 
      return _getWeather;

  }
}