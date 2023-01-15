import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/Bloc/states.dart';

import '../Constance.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutStates> {
  HomeLayoutCubit() : super(HomeLayoutInitialStates());

  static HomeLayoutCubit get(context) => BlocProvider.of(context);

  Database? database;

  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  void createDatabase() {
    openDatabase('todo.db', version: 1,
        onCreate: (Database database, int version) async {
      print('database create');
      await database
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY ,title TEXT ,data TEXT,time TEXT , status TEXT)')
          .then((value) {
        print('table created');
      }).catchError((error) {
        print('Error When Creating Table${error.toString()}');
      });
    }, onOpen: (database) {
      getData(database);
      print('database opened');
    }).then((value) {
      database = value;
      emit(HomeLayoutCreateStates());
    }).catchError((error) {});
  }

  void insertDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database?.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO tasks (title , data , time , status) VALUES("$title" , "$date" , "$time" , "true")')
          .then((value) {
        print('$value inserted success ');
        emit(HomeLayoutInsertStates());
        getData(database);
      }).catchError((error) {
        print('Error When Insert New Record ${error.toString()}');
      });
    });
  }

  void updateData({
    required String status,
    required int id,
  }) async {
    database!.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        [status, '$id']).then((value) {
      getData(database);
      emit(HomeLayoutUpdateStates());
    });
  }

  void deleteData({
    // required String status,
    required int id,
  }) async {
    database!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getData(database);
      emit(HomeLayoutDeleteStates());
    });
  }

  void getData(database) async {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    database!.rawQuery('SELECT * FROM tasks').then((value) {
      tasks = value;
      print(tasks);
      value.forEach((element) {
        if (element['status'] == 'true') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archivedTasks.add(element);
        }
        print(element['status']);
      });
      emit(HomeLayoutGetStates());
    });
  }
}
