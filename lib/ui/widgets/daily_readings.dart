import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_svg/svg.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/src/provider.dart';
import 'package:weather_app/core/models/get_weather.dart';
import 'package:weather_app/core/viewmodel/location.dart';

class DailyReadings extends StatelessWidget {
  GetWeather? weatherData;
  DailyReadings({
    Key? key,
    required this.weatherData,
  }) : super(key: key);

  late LocationProvider _locationProvider;

  @override
  Widget build(BuildContext context) {
    _locationProvider = context.watch<LocationProvider>();

    return Container(
      height: 348,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: const Color(0xffffffff).withOpacity(0.11),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            color: const Color(0xffffffff).withOpacity(0.5),
          )),
      child: Padding(
        padding: const EdgeInsets.only(top: 50.0, bottom: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/cloud.svg',
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Today",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 24),
                    ),
                    Text(
                      DateTime.now().toString().substring(0, 10),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 12),
                    )
                  ],
                )
              ],
            ),
            Text(
              (dynamic temp) {
                final celcius = (temp / 10).toStringAsFixed(1);
                return '${celcius.toString()}${"\u00B0"}';
              }(_locationProvider.weatherData?.list![0].temp?.day),
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 111),
            ),
            Text(
              "${_locationProvider.weatherData?.city?.name} - ${DateTime.now().hour.toString()}:${DateTime.now().minute.toString()} am",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  convert(dynamic temp) {
    print(temp);
    final celcius = (temp - 32) * 5 / 9;
    return celcius.toString();
  }
}
