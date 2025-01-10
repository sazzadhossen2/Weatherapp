import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/model/weather_model.dart';
class FtureListItem extends StatelessWidget {
  final  Forecastday? forecastday;
  const FtureListItem({super.key,this.forecastday});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white30,
        borderRadius: BorderRadius.circular(20)
      ),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      width: double.infinity,
      child: Row(
        children: [
          Image.network("https:${forecastday?.day?.condition?.icon??""}"),
          Expanded(
            child: Text(DateFormat.MMMEd().format(DateTime.parse(forecastday?.date?.toString()??"")),style: const TextStyle(
              color: Colors.white,fontSize: 20,fontWeight: FontWeight.w500
            ),),
          ),
          Expanded(child: Text(
           forecastday?.day?.condition?.text.toString()??"",style: const TextStyle(
            color: Colors.white
          ),
          )),
          Expanded(
              child: Text(
               "^${forecastday?.day?.maxtempC}/${forecastday?.day?.mintempC}",style: const TextStyle(
                color: Colors.white,fontSize: 21
              ),
              )),
        ],
      ),
    );
  }
}
