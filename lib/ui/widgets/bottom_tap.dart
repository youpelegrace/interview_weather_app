import 'package:flutter/material.dart';
import 'package:weather_app/core/models/get_weather.dart';
import 'package:weather_app/ui/pages/forecast_report.dart';

class BottomTap extends StatelessWidget {
  GetWeather? weather;
   BottomTap({
    Key? key, this.weather
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30.0),
            ),
          ),
          isScrollControlled: true,
          context: context,
          builder: (context) => ForecastReport(weather: weather)),
      child: Container(
        height: 60.5,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: const Color(0xffffffff).withOpacity(0.10),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 100.0),
          child: Row(
            children: const [
              Text(
                "Forecast report",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: 20,
              ),
              Icon(
                Icons.keyboard_arrow_up,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
