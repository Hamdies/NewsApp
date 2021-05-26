
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:headline/shared/bloc_observer.dart';
import 'package:headline/shared/network/local/cache_helper.dart';
import 'package:headline/shared/network/remote/dio_helper.dart';


import 'layout/news_app/cubit/modeState.dart';
import 'layout/news_app/cubit/mode_cubit.dart';
import 'layout/news_app/news_layout.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool isDark = CacheHelper.getData(key: 'isDark');

  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  MyApp(this.isDark);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ModeCubit()..changeDarkModeApp(sharedMode: isDark),
      child: BlocConsumer<ModeCubit,ModeState>(
        listener:(context,state) {},
        builder: (context,state){
          return MaterialApp(
            theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: AppBarTheme(
                    backwardsCompatibility: false,
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                    ),
                    backgroundColor: Colors.white,
                    elevation: 0.0,
                    titleTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold
                    ),
                    iconTheme: IconThemeData(
                        color: Colors.black
                    )
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    elevation: 0,
                    backgroundColor: Colors.white,
                    selectedLabelStyle: TextStyle(color: Colors.blue)
                ),
                textTheme: TextTheme(
                    bodyText1: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                    )
                )
            ),
            darkTheme: ThemeData(
                iconTheme: IconThemeData(
                    color: Colors.white),
                scaffoldBackgroundColor: Color(0xff15202B),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: Color(0xff15202B),
                    selectedLabelStyle: TextStyle(color: Colors.white),
                    elevation: 0,
                    selectedItemColor: Colors.white,
                    unselectedItemColor: Colors.grey
                ),
                appBarTheme: AppBarTheme(
                    backwardsCompatibility: false,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarIconBrightness: Brightness.light,
                        statusBarColor: Color(0xff15202B)
                    ),
                    backgroundColor: Color(0xff15202B),
                    elevation: 0.0,
                    titleTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold
                    ),
                  iconTheme: IconThemeData(
                    color: Colors.white
                  )
                ),
                textTheme: TextTheme(
                    bodyText1: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                    )
                )
            ),
            home:NewsLayout(),
            themeMode: ModeCubit.get(context).isDark ? ThemeMode.dark  : ThemeMode.light,
            debugShowCheckedModeBanner: false,
          );
        },
      )
    );
  }
}
