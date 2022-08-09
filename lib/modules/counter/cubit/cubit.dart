import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/modules/counter/cubit/state.dart';

class countercubit extends Cubit<counterstates>{
  countercubit() : super(counterintialstate());
 static countercubit get (context)=> BlocProvider.of(context);
 static int counter=1;
}