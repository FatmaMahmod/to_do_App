import 'package:flutter/material.dart';
import 'package:untitled4/shared/component/componant.dart';
import 'package:untitled4/shared/constant/constant.dart';
class new_tasks extends StatelessWidget {

  new_tasks({tasks});
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context,index)=>buildTaskitem(tasks[index]),
        separatorBuilder: (context,index)=>Container(
          width: double.infinity,
          height: 1,
          color: Colors.grey[300],
        ),
        itemCount: tasks.length);

  }
}
