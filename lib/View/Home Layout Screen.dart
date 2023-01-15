import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/Bloc/cubit.dart';
import 'package:todo/Bloc/states.dart';
import 'package:todo/View/Archived%20Screen.dart';
import 'package:todo/View/Done%20Screen.dart';
import 'package:todo/View/Task%20Screen.dart';

import '../Constance.dart';

class HomeLayoutScreen extends StatefulWidget {
  const HomeLayoutScreen({Key? key}) : super(key: key);

  @override
  _HomeLayoutScreenState createState() => _HomeLayoutScreenState();
}

List<Widget> screens = const [
  TaskScreen(),
  DoneScreen(),
  ArchivedScreen(),
];
List<String> name = ['Task Screen ', 'Done Screen', 'Archived Screen'];

class _HomeLayoutScreenState extends State<HomeLayoutScreen> {
  int currentIndex = 0;
  Database? database;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  bool isBottomSheetShown = false;
  IconData iconData = Icons.edit;
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeLayoutCubit()..createDatabase(),
      child: BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
        listener: (context, state) {
          if (state is HomeLayoutInsertStates) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) => Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text(name[currentIndex]),
            leading: Container(),
            leadingWidth: 5,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (isBottomSheetShown == true) {
                if (formKey.currentState!.validate()) {
                  HomeLayoutCubit.get(context).insertDatabase(
                    date: dateController.text,
                    title: titleController.text,
                    time: timeController.text,
                  );
                  // insertDatabase(
                  //   date:  dateController.text,
                  //   title:  titleController.text,
                  //   time: timeController.text,
                  // )?.then((value) {
                  //   getData(database).then((value) {
                  //     Navigator.pop(context);
                  //
                  //     setState(() {
                  //       isBottomSheetShown = false;
                  //       iconData = Icons.edit;
                  //       tasks = value;
                  //     });
                  //     print(tasks);
                  //   });
                  // Navigator.pop(context);
                  // isBottomSheetShown = false;
                  // setState(() {
                  //   iconData = Icons.edit;
                  // });
                  // });
                }
              } else {
                scaffoldKey.currentState
                    ?.showBottomSheet((context) {
                      return Container(
                        width: MediaQuery.of(context).size.width / 1,
                        height: MediaQuery.of(context).size.height / 2.33,
                        decoration:  const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.only(topRight: Radius.circular(50) , topLeft: Radius.circular(50)),
                        ),
                        child: buildBottomSheet(),
                      );
                    }, backgroundColor: Colors.transparent)
                    .closed
                    .then((value) {
                      // Navigator.pop(context);
                      isBottomSheetShown = false;
                      setState(() {
                        iconData = Icons.edit;
                      });
                    });
                isBottomSheetShown = true;
                setState(() {
                  iconData = Icons.add;

                });
                //  Timer(const Duration(seconds: 2), () {
                //   showDialog(
                //     context: context,
                //     builder: (context) {
                //       return  const AlertDialog(
                //         elevation: 0.0,
                //       backgroundColor: Colors.transparent,
                //       shape: RoundedRectangleBorder(),
                //       content: Image(image: AssetImage('images/verifay.png'),width: 250,height: 250,fit: BoxFit.cover,),
                //     );
                //     }
                //   );
                //   Future.delayed(const Duration(seconds: 2), () {
                //     Navigator.of(context).pop();
                //   });
                // });
              }
            },
            child: Icon(iconData),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.blue,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white54,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Tasks'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.verified_rounded), label: 'Done'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.archive), label: 'Archive'),
            ],
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
          // body: tasks.isEmpty ?  Center(child: CircularProgressIndicator(
          //   color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
          // )) : screens[currentIndex],

          body: screens[currentIndex],
        ),
      ),
    );
  }

//   void createDatabase() async {
//     database = await openDatabase('todo.db', version: 1,),
//         onCreate: (Database database, int version) async {
//       print('database create');
//       await database
//           .execute(
//               'CREATE TABLE tasks (id INTEGER PRIMARY KEY ,title TEXT ,data TEXT,time TEXT , status TEXT)')
//           .then((value) {
//         print('table created');
//       }).catchError((error) {
//         print('Error When Creating Table${error.toString()}');
//       });
//     }, onOpen: (database) {
//       getData(database).then((value) {
//         setState(() {
//           tasks = value;
//         });
//         print(tasks);
//       });
//       print('database opened');
//     });
//   }
//
//   Future ? insertDatabase({
//   required String title,
//   required String time,
//   required String date,
// })async {
//     return await database?.transaction((txn) {
//       return txn
//           .rawInsert(
//               'INSERT INTO tasks (title , data , time , status) VALUES("$title" , "$date" , "$time" , "true")')
//           .then((value) {
//         print('$value inserted success ');
//       }).catchError((error) {
//         print('Error When Insert New Record ${error.toString()}');
//       });
//     });
//   }
//
  Widget buildBottomSheet() {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // const SizedBox(
          //   height: 25,
          // ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: titleController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'title is not found';
                }
                return null;
              },
              onTap: () {},
              decoration: InputDecoration(
                  hintText: 'Add Title',
                  hintStyle: const TextStyle(color: Colors.white),
                  prefixIcon: const Icon(Icons.title,color: Colors.white,),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: timeController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'time is not found';
                }
                return null;
              },
              onTap: () {
                // showDatePicker(
                //     context: context,
                //     initialDate: DateTime.now(),
                //     firstDate: DateTime(1990),
                //     lastDate: DateTime(2050)
                // ).then((value) {
                //   print(value.toString());
                // });

                showTimePicker(context: context, initialTime: TimeOfDay.now())
                    .then((value) {
                  timeController.text = value!.format(context).toString();
                  print(value.format(context));
                });
              },
              readOnly: true,
              decoration: InputDecoration(
                  hintText: 'Add Time',
                  hintStyle: const TextStyle(color: Colors.white),
                  prefixIcon: const Icon(Icons.timer , color: Colors.white,),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: dateController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'date is not found';
                }
                return null;
              },
              onTap: () {
                showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1990),
                        lastDate: DateTime(2050))
                    .then((value) {
                  // DateFormat.yMMMd().format(value);
                  print(DateFormat.yMMMd().format(value!));
                  dateController.text = DateFormat.yMMMd().format(value);
                }).then((value) {
                  // dateController.text = value
                  print(value.toString());
                });
              },
              readOnly: true,
              decoration: InputDecoration(
                  hintText: 'Add Date',
                  hintStyle: const TextStyle(color: Colors.white),
                  prefixIcon: const Icon(Icons.date_range,color: Colors.white,),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white))),
            ),
          ),
        ],
      ),
    );
  }
//
//   Future<List<Map> > getData(database)async{
//     return await database!.rawQuery('SELECT * FROM tasks');
//   }
}
