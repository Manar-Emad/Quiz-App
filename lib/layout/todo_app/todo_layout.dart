import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/states.dart';

class HomeLayoutScreen extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  List<Map> tasks = [];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {
          if(state is AppInsertDataBaseState){
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit=AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                  cubit.titles[cubit.currentIndex]
              ),
            ),
            body: ConditionalBuilder(
              builder: (context) => cubit.screens[cubit.currentIndex],
              condition: state is! AppGetDataBaseLoadingState,
              fallback: (context) => Center(child: CircularProgressIndicator()
          ),
            ),
            floatingActionButton: FloatingActionButton(
                child:Icon(cubit.fabIcon),
                onPressed: () {
                  if (cubit.isButtomSheetShown) {
                    if (formKey.currentState!.validate()) {
                      cubit.insertToDatabase(title: titleController.text, date: dateController.text, time: timeController.text);
                    }
                  }
                  else {
                    scaffoldKey.currentState
                        ?.showBottomSheet(
                          (context) => Container(
                            color: Colors.white,
                            padding: const EdgeInsets.all(20.0),
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  DefaultFormFeild(
                                    controller: titleController,
                                    type: TextInputType.text,
                                    validate: (String value) {
                                      if (value.isEmpty) {
                                        return 'value must not be empty';
                                      }
                                      return null;
                                    },
                                    label: 'Task Title',
                                    prefix: Icons.title,
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  DefaultFormFeild(
                                    controller: timeController,
                                    type: TextInputType.datetime,
                                    onTap: () {
                                      showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now())
                                          .then((value) {
                                         timeController.text =
                                            value!.format(context).toString();
                                        print(value.format(context));
                                      });
                                    },
                                    validate: (String value) {
                                      if (value.isEmpty) {
                                        return 'time must not be empty';
                                      }
                                      return null;
                                    },
                                    label: 'Task Time',
                                    prefix: Icons.watch_later_outlined,
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  DefaultFormFeild(
                                    controller: dateController,
                                    type: TextInputType.datetime,
                                    onTap: () {
                                      print('Dating Tapped');
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.parse('4-2-2022'),
                                      ).then((value) {
                                        // دي عشان اظهر التاريخ بنمط كتابة معين
                                       dateController.text =
                                            DateFormat.yMMMd().format(value!);
                                      });
                                    },
                                    validate: (String value) {
                                      if (value.isEmpty) {
                                        return 'date must not be empty';
                                      }
                                      return null;
                                    },
                                    label: 'Task Date',
                                    prefix: Icons.calendar_today,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          elevation: 20,
                        )
                        .closed
                        .then((value) {
                      //Navigator.pop(context);
                      cubit.AppChangeBottomSheetState(isShown: false, icon:Icons.edit, );

                      // isButtomSheetShown = false;
                      // setState(() {
                      // fabIcon = Icons.edit;
                      // });
                    });
                    cubit.AppChangeBottomSheetState(isShown: true, icon:Icons.add, );
                    // setState(() {
                    // fabIcon = Icons.add;
                    // });
                  }
                },
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                cubit.ChangeIndex(index);
              },
              items:const [
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle_outline), label: 'Done'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive), label: 'Archived'),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<String> GetNames() async {
    return 'mohamed emad';
  }



}
