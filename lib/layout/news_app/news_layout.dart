import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';


import 'cubit/cubit.dart';
import 'cubit/mode_cubit.dart';
import 'cubit/states.dart';

class NewsLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()..getBusiness()..getScience()..getSport(),
      child: BlocConsumer<NewsCubit,NewsStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text("News App"),
              actions: [
                IconButton(
                    onPressed: (){
                      ModeCubit.get(context).changeDarkModeApp();
                    },
                    icon: Icon(Icons.brightness_4_outlined,)),

              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              items: cubit.bottomItems,
              onTap: (index) {
                cubit.bottomNavBarChange(index);
              }
            ),
            body: cubit.screens[cubit.currentIndex],
          );
        },
      ),
    );
  }
}
