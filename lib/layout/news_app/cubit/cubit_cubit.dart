import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../modules/news_app/business/business_screen.dart';
import '../../../modules/news_app/science/science_screen.dart';
import '../../../modules/news_app/sports/sports_screen.dart';
import '../../../shared/cubit/states.dart';
import '../../../shared/network/remote/dio_helper.dart';

part 'cubit_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitialState());

  /// انا هنا بعمل اوبجكت من الNewsCubit عشان اعرف استخدمه ف كل الاسكرينات
  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  ///هعمل ليست عشاان احط فيها الitems  بتاع ال bottomnavbar
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];

  List<Widget>screens=[
    BusinessScreen(),
    SportsScreen(),
    SciencesScreen(),
  ];
  //----------------------------------------------------------------------------
  void ChangeBottomNavBar(int index){
    currentIndex= index;
    if(index==1)
      getSports();
    if(index==2)
      getScience();
    emit(NewsBottomNavState());
  }
  //----------------------------------------------------------------------------
  List<dynamic>business=[];

  /// هستدعيها ف لحظة كريتة الكيوبت
void getBusiness(){

  emit(NewsGetBusinessLoadingState());

  DioHelper.getData(
    url: 'v2/top-headlines',
    query: {
      'country': 'eg',
      'category':'business',
      'apiKey':'6742fabb4bb64b96911b0374a27954af'
    },
  ).then((value) {
    ///انا هنا هطبع الداتا اللي جاية ليا
    //print(value.data['articles'][0]['title']);
    business=value.data['articles'];
    print(business[0]['title']);
    emit(NewsGetBusinessSuccessState());
  }).catchError((error){
    print(error.toString());
    emit(NewsGetBusinessErrorState(error.toString()));
  });
}
  //----------------------------------------------------------------------------
  List<dynamic>sports=[];

  /// هستدعيها ف لحظة كريتة الكيوبت
  void getSports(){

    emit(NewsGetBusinessLoadingState());
    if(sports.length==0){
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category':'sports',
          'apiKey':'6742fabb4bb64b96911b0374a27954af'
        },
      ).then((value) {
        ///انا هنا هطبع الداتا اللي جاية ليا
        //print(value.data['articles'][0]['title']);
        sports=value.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    }else{
      emit(NewsGetSportsSuccessState());
    }
  }
  //----------------------------------------------------------------------------

  List<dynamic>science=[];
  /// هستدعيها ف لحظة كريتة الكيوبت
  void getScience(){

    emit(NewsGetBusinessLoadingState());

    if(science.length==0){DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category':'science',
        'apiKey':'6742fabb4bb64b96911b0374a27954af'
      },
    ).then((value) {
      ///انا هنا هطبع الداتا اللي جاية ليا
      //print(value.data['articles'][0]['title']);
      science=value.data['articles'];
      print(science[0]['title']);
      emit(NewsGetScienceSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetScienceErrorState(error.toString()));
    });
    }else{
      emit(NewsGetScienceSuccessState());
    }
  }

  //----------------------------------------------------------------------------
  List<dynamic>search=[];
  /// هستدعيها ف لحظة كريتة الكيوبت
  void getSearch(String value){

    emit(NewsGetBusinessLoadingState());
    /// هنا كل مرة هيخلي الليست فاضية بعد ما يعمل emit
    //modules.news_app.search=[];

    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q':'value',
        'apiKey':'6742fabb4bb64b96911b0374a27954af'
      },
    ).then((value) {
      ///انا هنا هطبع الداتا اللي جاية ليا
      //print(value.data['articles'][0]['title']);
      search=value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }

}
