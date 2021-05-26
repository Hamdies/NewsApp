
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frefresh/frefresh.dart';
import 'package:headline/layout/news_app/cubit/cubit.dart';
import 'package:headline/layout/news_app/cubit/states.dart';
import 'package:headline/shared/components/components.dart';
import 'package:lottie/lottie.dart';


class ScienceScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var list = NewsCubit.get(context).science;
        return ConditionalBuilder(
          condition: list.length>0 ,
          builder: (context)=>FRefresh(
            child: ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context,index)=>buildArticleItem(list[index],context),
                separatorBuilder: (context,index)=>myDivider(),
                itemCount: 10),
          ),
          fallback: (context)=>Center(
            child: Container(
              width: 250,
              height: 250,
              child: Center
                (child: Lottie.asset('assets/loading.json'),),),
          ),
        );
      },
    );

  }
}
