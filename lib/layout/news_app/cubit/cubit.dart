
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:headline/layout/news_app/cubit/states.dart';
import 'package:headline/modules/business/business_screen.dart';
import 'package:headline/modules/science/science_screen.dart';
import 'package:headline/modules/settings/setting_screen.dart';
import 'package:headline/modules/sport/sport_screen.dart';
import 'package:headline/shared/network/remote/dio_helper.dart';
import 'package:lottie/lottie.dart';


class NewsCubit extends Cubit <NewsStates> {
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems =
  [
    BottomNavigationBarItem(
         icon: Container(
           width: 50,
             height: 35,
             child: Lottie.asset("assets/busy.json")),
      label: "business"
    ),
    BottomNavigationBarItem(
         icon: Container(
             width: 50,
             height: 30,
             child: Lottie.asset("assets/science.json")),
      label: "Science"
    ),
    BottomNavigationBarItem(
        icon: Container(
            width: 50,
            height:30,
            child: Lottie.asset("assets/sport.json")),
        label: "Sport"
    ),
  ];
  List <Widget> screens = [
    BusinessScreen(),
    ScienceScreen(),
    SportScreen(),
    Settings()
  ];
  void bottomNavBarChange(int index){
    currentIndex = index;
    if(index==1){
      getScience();
    }
    if(index==2){
      getSport();
    }
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];
  void getBusiness (){
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'business',
          'apiKey':'cb81a0c8f61b45beaf75ac8d154bf223'
        }
    ).then((value)  {
      emit(NewsGetBusinessSuccessState());
      business = value.data['articles'];
      print(business[0]['title']);
    }).catchError((error){
      emit(NewsGetBusinessErrorState(error.toString()));
      print(error.toString());
  });
  }

  List<dynamic> science = [];
  void getScience (){
    emit(NewsGetScienceLoadingState());
    if(science.length==0){

      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'science',
            'apiKey':'cb81a0c8f61b45beaf75ac8d154bf223'
          }
      ).then((value)  {

        science = value.data['articles'];
        print(science[0]['title']);
      }).catchError((error){
        emit(NewsGetScienceErrorState(error.toString()));
        print(error.toString());
      });
    } else{
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> sport = [];
  void getSport (){
    emit(NewsGetSportLoadingState());
    if(sport.length==0){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'sports',
            'apiKey':'cb81a0c8f61b45beaf75ac8d154bf223'
          }
      ).then((value)  {
        sport = value.data['articles'];
        print(sport[0]['title']);
      }).catchError((error){
        emit(NewsGetSportErrorState(error.toString()));
        print(error.toString());
      });
    }else{
      emit(NewsGetSportSuccessState());
    }
  }

}
