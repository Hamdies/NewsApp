
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:headline/shared/network/local/cache_helper.dart';
import 'modeState.dart';

class ModeCubit extends Cubit<ModeState>{
  ModeCubit() : super(InitilModeState());

  static ModeCubit get(context) => BlocProvider.of(context);


  bool isDark = false;
  void changeDarkModeApp({bool sharedMode}){
    if(sharedMode != null)
    {
      isDark=sharedMode;
      emit(AppDarkModeState());
    }
    else{
      isDark = !isDark;
      CacheHelper.putData(key: 'isDark', value: isDark).then((value)
      {
        emit(AppDarkModeState());

      });
    }

  }
}
