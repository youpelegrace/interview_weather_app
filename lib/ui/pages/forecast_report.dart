import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/src/provider.dart';
import 'package:weather_app/core/models/get_weather.dart';
import 'package:weather_app/core/viewmodel/location.dart';

class ForecastReport extends StatelessWidget {
  GetWeather? weather;
  ForecastReport({Key? key, this.weather}) : super(key: key);
         late LocationProvider _locationProvider;


  @override
  Widget build(BuildContext context) {
                _locationProvider = context.watch<LocationProvider>();

    final list = _locationProvider.weatherData!.list;
   
    return SafeArea(
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Divider(
              indent: 130,
              endIndent: 130,
              thickness: 2,
              color: Color(0xff9D9D9D),
            ),
            const SizedBox(
              height: 19,
            ),
            Container(
              height: 43,
              width: 152,
              decoration: BoxDecoration(
                  color: const Color(0xff7047EB).withOpacity(0.10),
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text(
                    "Forecast report",
                    style: TextStyle(color: Color(0xff8862FC)),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(0xff7047EB),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  "Today",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 106,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: const Color(0xffD5C7FF),
                  ),
                  borderRadius: BorderRadius.circular(16)),
              child: Wrap(
                //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: SizedBox(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) =>  HourlyReport(listElement: list![index], index:index),
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                          width: 40,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const  Text(
                "Next forecast ",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
              Container(
                height: 36,
                width: 100,
                decoration: BoxDecoration(
                    color: const Color(0xff7047EB),
                    borderRadius: BorderRadius.circular(8)),
                child: const Center(
                  child: Text(
                    "Five Days",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ]),
           const SizedBox(
              height: 15,
            ),
            Container(
              height: 246,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: const Color(0xffD5C7FF),
                  ),
                  borderRadius: BorderRadius.circular(16)),
              child: Wrap(
                children: 
                  [Column(
                    //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: SizedBox(
                          height: 243,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.separated(
                            itemCount: list!.length,
                            itemBuilder: (context, index) =>  DailyReport(listElement: list[index], index:index),
                            separatorBuilder: (BuildContext context, int index) =>
                                const Divider(
                              height: 20,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class DailyReport extends StatelessWidget {
  ListElement listElement;
  int index;
   DailyReport({
    Key? key, required this.listElement, required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:  [
        Text(
          "${DateTime.now().add(Duration(days:index)).toString().substring(0,10)}",
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w400),
        ),
       FaIcon(FontAwesomeIcons.cloud, color: Color(0xffFA9E42),),
         Text((dynamic temp){
                        final celcius = (temp /10).toStringAsFixed(1);

          return "${celcius.toString()}${ "\u00B0"}";
        }(listElement.temp!.day)
          ,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}

class HourlyReport extends StatelessWidget {
   ListElement listElement;
  int index;
   HourlyReport({
    Key? key, required this.index, required this.listElement
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text((dynamic temp){
                        final celcius = (temp /10).toStringAsFixed(1);

          return "${celcius.toString()}${ "\u00B0"}";
        }(listElement.temp!.day)
          ,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        FaIcon(FontAwesomeIcons.cloudSunRain, color: Color(0xffFA9E42)),
        Text(
          "${DateTime.now().add(Duration(days:index)).toString().substring(0,10)}",
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}


