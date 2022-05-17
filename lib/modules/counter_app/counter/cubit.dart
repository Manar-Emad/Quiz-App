import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/modules/counter_app/counter/states.dart';

class CounterCubit extends Cubit<CounterStates>
{
  CounterCubit(initialState , counterStates) : super(initialState);

  static CounterCubit get(context) => BlocProvider.of(context);
  int counter= 1 ;

  void minus(){
    counter--;
    emit(CounterMinusState(counter));
  }
  void plus(){
    counter++;
    emit(CounterPlusState(counter));
  }
}
