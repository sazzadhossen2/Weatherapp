

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/model/weather_model.dart';

class HourlyWeather extends StatelessWidget {

  final Hour?hour;
  const HourlyWeather({super.key,this.hour});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      width: 120,
      decoration: BoxDecoration(
        color: Colors.white30,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        children: [
          const SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(hour?.tempC?.toString()??"",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
              const Text("o",style: TextStyle(color: Colors.white),)
            ],
          ),
          const SizedBox(height: 8,),
          Container(
            height: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,color: Colors.white10
            ),
            child: Image.network("https:${hour?.condition?.icon??""}"),
          ),
          const SizedBox(height: 8,),
          Text(DateFormat.j().format(DateTime.parse(hour?.time?.toString()??"")),style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),)
        ],
      ),
    );
  }
}
