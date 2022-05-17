part of 'cubit_cubit.dart';

@immutable
abstract class NewsState {}

class NewsInitialState extends NewsState {}

class NewsBottomNavState extends NewsState {}

/// GetBusiness STATES
class NewsGetBusinessLoadingState extends NewsState {}

class NewsGetBusinessSuccessState extends NewsState {}

class NewsGetBusinessErrorState extends NewsState {
  /// هنا بقوله لو حصل ايرور اظهره ليا
  final String error;
  NewsGetBusinessErrorState(this.error);
}

/// GetSPORTS STATES
class NewsGetSportsLoadingState extends NewsState {}

class NewsGetSportsSuccessState extends NewsState {}

class NewsGetSportsErrorState extends NewsState {
  /// هنا بقوله لو حصل ايرور اظهره ليا
  final String error;
  NewsGetSportsErrorState(this.error);
}
/// GetScience STATES
class NewsGetScienceLoadingState extends NewsState {}

class NewsGetScienceSuccessState extends NewsState {}

class NewsGetScienceErrorState extends NewsState {
  /// هنا بقوله لو حصل ايرور اظهره ليا
  final String error;
  NewsGetScienceErrorState(this.error);
}

/// CHANGE MODE STATE
class ChangeAppModeState extends AppStates{}

/// SEARCH STATES
class NewsGetSearchLoadingState extends NewsState {}

class NewsGetSearchSuccessState extends NewsState {}

class NewsGetSearchErrorState extends NewsState {
  /// هنا بقوله لو حصل ايرور اظهره ليا
  final String error;
  NewsGetSearchErrorState(this.error);
}



