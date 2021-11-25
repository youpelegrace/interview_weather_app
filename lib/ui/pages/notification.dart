import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/src/provider.dart';
import 'package:weather_app/core/models/get_weather.dart';
import 'package:weather_app/core/viewmodel/location.dart';
import 'package:weather_app/ui/pages/details.dart';

class NotificationModal extends StatelessWidget {
  GetWeather notificationData;

  NotificationModal({Key? key, required this.notificationData})
      : super(key: key);

       
      late LocationProvider _locationProvider;

  @override
  Widget build(BuildContext context) {
     _locationProvider = context.read<LocationProvider>();
     final weatherData = _locationProvider.weatherData;
    return SafeArea(
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
                child: const Center(
                  child: Text(
                    "Your Notifications",
                    style: TextStyle(color: Color(0xff8862FC)),
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    "New",
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                 final message =  weatherData!.list![index].weather!.map((e) => (e.description)).toList().join(", ");
                 final date = DateTime.now().add(Duration(days: index)).toString().substring(0, 10);
                 final cityName = weatherData.city;
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(weatherData: weatherData.list![index], cityName: cityName!.name)));
                    },
                    child: Row(
                    children: [
                      FaIcon(FontAwesomeIcons.cloudSunRain,
                          color: Color(0xffFA9E42)),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                           date,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            message),
                        ],
                      ),
                    ],
                                  ),
                  );},
                itemCount: weatherData!.list!.length,
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(height: 40),
                shrinkWrap: true,

                physics: NeverScrollableScrollPhysics(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
