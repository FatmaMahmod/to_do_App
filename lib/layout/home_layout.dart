import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled4/modules/archive_tasks/archieve_tasks.dart';
import 'package:untitled4/modules/done_tasks/done_tasks.dart';
import 'package:untitled4/modules/new_tasks/new_tasks.dart';
import 'package:untitled4/shared/constant/constant.dart';

class homelayout extends StatefulWidget {


  @override
  State<homelayout> createState() => _homelayoutState();
}

class _homelayoutState extends State<homelayout> {
  bool isbottomsheetshown = false;
  int currentindex=0;
  Database database;
  IconData fapicon = Icons.edit;
  var control = TextEditingController();
  var controltime = TextEditingController();
  var controldata = TextEditingController();
  var scafoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();
  //List<Map>tasks=[];
  List<Widget>screen=[
    new_tasks(tasks: tasks),done_tasks(),
    archive_tasks(),

  ];
  @override
  void initState(){
    super.initState();
    creatDatabase();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafoldkey,
      body :tasks.length==0 ?Center(child: CircularProgressIndicator()) : screen[currentindex],
      appBar: AppBar(
        title: Text(
          'ant'
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          fapicon,
        ),
        onPressed: (){
          //insertToDatabase();
          if(isbottomsheetshown){
            if(formkey.currentState.validate()){
              insertToDatabase(controltime.text, controldata.text, control.text).then((value) {
            Navigator.pop(context);
            isbottomsheetshown= false;
            setState(() {
              fapicon= Icons.edit;

            });
            });
                  }
          }
          else {
            scafoldkey.currentState.showBottomSheet((context) =>
                 Container(
                    color:Colors.grey[100] ,
                    padding: EdgeInsets.all(20),
                    child: Form(
                      key: formkey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(

                            controller: control,
                            decoration:InputDecoration (

                              border:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              prefixIcon: Icon(Icons.text_fields_outlined,),
                              label: Text(
                                'Tasl Title',
                              ),
                            ),
                            validator:  (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },

                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(

                            controller: controltime,
                            validator:  (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            decoration:InputDecoration (

                              border:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              prefixIcon: Icon(Icons.watch_later,),
                              label: Text(
                                'Tasl Time',
                              ),
                            ),
                            onTap: (){
                              showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now()).then((value) {
                                    controltime.text= value.format(context).toString();

                                    print('hhhhh ${value.format(context)}');
                              });
                            },


                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(

                            controller: controldata,
                            validator:  (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            decoration:InputDecoration (

                              border:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              prefixIcon: Icon(Icons.data_saver_on_sharp,),
                              label: Text(
                                'Task Data',
                              ),
                            ),
                            onTap: (){
                             showDatePicker(
                                 context: context,
                                 initialDate: DateTime.now(),
                                 firstDate: DateTime.now(),
                                 lastDate: DateTime.parse('2022-11-03'),
                             ).then((value) {
                               controldata.text= DateFormat.yMMMd().format(value);
                             });
                            },


                          ),
                        ],
                      ),
                    ),
                  ),
                ).closed.then((value) {
                  //Navigator.pop(context);
                  isbottomsheetshown=false;
                  setState(() {
                    fapicon= Icons.edit;

                  });
            });
            isbottomsheetshown = true;
            setState(() {
              fapicon= Icons.add;

            });
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentindex,
        onTap: (index){
          setState(() {
            currentindex=index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(
            Icons.menu,
          ),
            label: 'Tasks'
          ),
          BottomNavigationBarItem(icon: Icon(
            Icons.check,
          ),
              label: 'Done'
          ),
          BottomNavigationBarItem(icon: Icon(
            Icons.archive,
          ),
              label: 'Archive'
          ),
        ],
      ),
    );
  }
  Future<void> creatDatabase() async {
     database= await openDatabase('todo.db',
    version: 1,
      onCreate: (database,version){
      print('database created');
      database.execute('CREATE TABLE Tasks (id INTEGER PRIMARY KEY, title TEXT, data TEXT, time TEXT, status TEXT)').then((value){
        print ('table created');

      }).catchError((onError){
        print('error on create table ${onError}');
      });
      },
      onOpen: (database){
       getDatabase(database).then((value) {

           tasks=value;


         print(tasks);
       });
        print('database opened');
      },
    );
  }
  Future insertToDatabase(
      @required String time,
      @required String data,
      @required String title)async{
    return await database.transaction((txn){
     txn.rawInsert('INSERT INTO tasks(title, data, time, status) '
         'VALUES ("$title", "$data", "$time", "new")'
        ).then((value){
          print('$value inseted succesfully');
           }
     ).catchError((onError) {
       print('inseted error${onError.toString()}');
     });
    });
  }

  Future<List<Map>> getDatabase(database)async{
   return await database.rawQuery('SELECT * FROM tasks');
    //print("ggggggggg${Tasks}");
  }
}
