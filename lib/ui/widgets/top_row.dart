import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:weather_app/core/models/get_weather.dart';
import 'package:weather_app/core/viewmodel/location.dart';
import 'package:weather_app/ui/pages/notification.dart';

class HeaderRow extends StatefulWidget {
  GetWeather? notificationData;

  HeaderRow({Key? key, this.notificationData}) : super(key: key);

  @override
  State<HeaderRow> createState() => _HeaderRowState();
}

class _HeaderRowState extends State<HeaderRow> {
  late LocationProvider _locationProvider;

  String? cityName;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    _locationProvider = context.watch<LocationProvider>();

    return isLoading
        ? CircularProgressIndicator()
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 43,
                width: 200,
                child: TextField(
                  onChanged: (value) {
                    cityName = value;
                  },
                  decoration: InputDecoration(
                      hintText: "Search City...",
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
                      prefixIcon: InkWell(
                        onTap: () async {
                          setState(() {
                            isLoading = true;
                          });
                          await _locationProvider.getCityWeather(cityName!);
                          setState(() {
                            isLoading = false;
                          });
                        },
                        child: const Icon(
                          Icons.room,
                          color: Colors.white,
                        ),
                      )),
                ),
              ),
              GestureDetector(
                onTap: () => showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30.0),
                      ),
                    ),
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => NotificationModal(
                          notificationData: widget.notificationData!,
                        )),
                child: Container(
                  height: 43,
                  width: 44,
                  decoration: BoxDecoration(
                      color: const Color(0xffffffff).withOpacity(0.10),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Icon(
                    Icons.notifications_none,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
  }
}
