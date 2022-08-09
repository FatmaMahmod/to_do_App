import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/modules/counter/cubit/cubit.dart';
import 'package:untitled4/modules/counter/cubit/state.dart';

class Counter extends StatelessWidget {
  int count=0;
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>countercubit(),
      child: BlocConsumer <countercubit,counterstates>(
        listener: (context , state){},
        builder:(context,state){
          return Scaffold(
            appBar: AppBar(
              title: Text(
                  'Counter'
              ),

            ),
            body:  Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center
                  ,

                  children: [
                    TextButton(
                      child: Text(
                        'PLUS',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      onPressed:() {

                        countercubit.get(context).counter++;


                      },


                    ),
                    Text(
                      '${countercubit.get(context).counter}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    TextButton(
                      child: Text(
                        'MINS',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      onPressed:() {

                        countercubit.get(context).counter--;


                      },


                    ),

                  ],
                ),
              ),
            ),
          );
        },

      ),
    );
  
}


}
