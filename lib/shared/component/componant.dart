import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled4/shared/constant/constant.dart';

Widget buildTaskitem(Map modle)=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      CircleAvatar(
        radius: 50,
        child: Text(
            '${modle['time']}'
        ),
      ),
      SizedBox(
        width: 20,
      ),
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        //mainAxisAlignment: MainAxisAlignment.start,
        children: [

          Text(
            '${modle['title']}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${modle['data']}',
            style: TextStyle(
              // fontSize: 10,
              color: Colors.grey,
              //fontWeight: FontWeight.bold,
            ),
          ),

        ],
      ),
    ],
  ),
);