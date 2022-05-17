import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/modules/todo_app/archived_tasks/archived-tasks_screen.dart';
import 'package:todo_app/shared/cubit/states.dart';

import '../../modules/todo_app/done_tasks/done_tasks_screen.dart';
import '../../modules/todo_app/new_tasks/new_tasks_screen.dart';
import '../network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    NewTasksScreen(),
    NewDoneTasksScreen(),
    ArchivedTasksScreen(),
  ];
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void ChangeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  late Database database;
  late final List<Map> newTasks;
  late final List<Map> doneTasks;
  late final List<Map> archivedTasks;

  void createDatabase() {
    openDatabase('todo.db', version: 1, onCreate: (database, version) {
      //id integer
      //title string
      //date string
      //time string
      //status string
      print('database created');
      //كدا هنسمي ال table tasks  وهندخل فيه اسم الcoulmns
      database
          .execute('CREATE TABLE tasks('
              'id INTEGER PRIMARY KEY'
              //انا كاتبة primary key عشان البرنامج يملي الخانة دي لوحده يرقم الid
              ' ,title TEXT,'
              'date TEXT,'
              'time TEXT , '
              'status STRING ) '
              '')
          .then((value) {
        print('table created');
      }).catchError((error) {
        print('Error when creating table ${error.toString()}');
      });
    }, onOpen: (database) {
      getDataFromDatabase(database);
      print('database opened');
    });
  }

  insertToDatabase({
    required String title,
    required String date,
    required String time,
  }) async {
    await database.transaction((txn) async {
      txn
          .rawInsert(
        'INSERT INTO tasks (title,date,time,status) VALUES("$title" ,"$date","$time","new")',
      )
          .then((value) {
        print('$value inserted successfully');
        emit(AppInsertDataBaseState());
        getDataFromDatabase(database);
      }).catchError((error) {
        print('Error when inserting new record ${error.toString()}');
      });
      return null;
    });
  }

  void getDataFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];

    emit(AppGetDataBaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archivedTasks.add(element);
        }
      });
      emit(AppCreateDataBaseState());
    });
  }

  void updateData({required String status, required int id}) async {
    database.rawUpdate('UPDATE tasks SET status = ?, value = ? WHERE id = ?',
        ['$status', id]).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDataBaseState());
    });
  }

  void deleteData({required int id}) async {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDataBaseState());
    });
  }

  bool isButtomSheetShown = false;
  IconData fabIcon = Icons.edit;
  void AppChangeBottomSheetState({required isShown, required icon}) {
    isShown = isButtomSheetShown;
    icon = fabIcon;
  }

  bool isDark = false;
  void changeAppMode({bool? fromShared}) {
    if(fromShared!=null){
      isDark = fromShared;
      emit(ChangeAppModeState());
    }else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(ChangeAppModeState());
      });
    }
  }
}
