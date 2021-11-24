import 'package:flutter/material.dart';
import 'package:weather_app/core/models/get_weather.dart';
import 'package:weather_app/ui/pages/notification.dart';

class HeaderRow extends StatelessWidget {
  GetWeather? notificationData;
   HeaderRow({
    Key? key, this.notificationData
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 43,
          width: 159,
          child: TextField(
            decoration: InputDecoration(
                hintText: "Lagos, Nigeria",
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
        GestureDetector(
          onTap: () => showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30.0),
                ),
              ),
              isScrollControlled: true,
              context: context,
              builder: (context) =>  NotificationModal(notificationData: notificationData!,)),
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
