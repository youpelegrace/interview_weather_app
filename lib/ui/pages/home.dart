import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/viewmodel/location.dart';
import 'package:weather_app/ui/widgets/bottom_tap.dart';
import 'package:weather_app/ui/widgets/daily_readings.dart';
import 'package:weather_app/ui/widgets/top_row.dart';
import 'package:http/http.dart' as http;


class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);



  @override
  _HomePageState createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {

   

   late LocationProvider _locationProvider;

   bool isLoading = false;

  Future getUserLocation() async{
    setState(() {
          isLoading = true;
        });
    await context.read<LocationProvider>().getUserLocation();
    setState(() {
          isLoading = false;
        });
    // print(_locationProvider.currentLatitude);
  
  }
@override
  void initState() {
    (){
    getUserLocation();

    }();
    
  }


  @override
  Widget build(BuildContext context) {
    
    _locationProvider = context.read<LocationProvider>();

    return Scaffold(
      body: SafeArea(
        child: isLoading? CircularProgressIndicator(): ListView(
          children: 
            [Padding(
              padding: const EdgeInsets.only(left:27.0, right: 27, top: 60),
              child: Column(
                children: [
                 HeaderRow(notificationData: _locationProvider.weatherData),
                 SizedBox(height: 101,),
                  DailyReadings(weatherData: _locationProvider.weatherData,),
                  SizedBox(
                    height: 120,
                  ),
                  BottomTap(weather:_locationProvider.weatherData)
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}




