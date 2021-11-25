import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/src/provider.dart';
import 'package:weather_app/core/models/get_weather.dart';
import 'package:weather_app/core/viewmodel/location.dart';
import 'package:weather_app/ui/widgets/daily_readings.dart';
import 'package:weather_app/ui/widgets/top_row.dart';

class DetailScreen extends StatefulWidget {
  ListElement? weatherData;
  String? cityName;

  DetailScreen({Key? key, this.weatherData, this.cityName}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late LocationProvider _locationProvider;

  @override
  Widget build(BuildContext context) {
    _locationProvider = context.read<LocationProvider>();
    return Scaffold(
        body: SafeArea(
            child: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 27.0, right: 27, top: 60),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.keyboard_arrow_left,
                        color: Colors.white,
                        size: 40,
                      )),
                  SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    height: 43,
                    width: 200,
                    child: TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                          hintText: "City!",
                          hintStyle: const TextStyle(
                              color: Color(0xffffffff),
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none),
                          focusColor: Colors.white,
                          filled: true,
                          fillColor: const Color(0xffffffff).withOpacity(0.10),
                          prefixIcon: const Icon(
                            Icons.room,
                            color: Colors.white,
                          )),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 101,
              ),
              Container(
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
                        }(widget.weatherData?.temp?.day),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 111),
                      ),
                      Text(
                        "${widget.cityName} - ${DateTime.now().hour.toString()}:${DateTime.now().minute.toString()} am",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    )));
  }
}
