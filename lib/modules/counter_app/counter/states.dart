abstract class CounterStates{}

class CounterInitialStates extends CounterStates{}

 class CounterPlusState extends CounterStates{
  late final int counter;
  CounterPlusState(this.counter);
}

class CounterMinusState extends CounterStates{
  late final int counter;

  CounterMinusState(this.counter);
}