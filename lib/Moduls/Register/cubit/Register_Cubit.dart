import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../Models/Login/Login_Class.dart';
import '../../../Shared/network/Dio_Helper.dart';
import 'Register_State.dart';

class RegisterCubit extends Cubit<RegisterState>
{
  RegisterCubit():super(RegisterInitState());

  static RegisterCubit get(context)=>BlocProvider.of(context);

  bool isHide=true;

  void changePass()
  {
    isHide =!isHide;
    emit(RegisterChangePassState());
  }


   UserLogin? userLogin;
  void MakeRegister({
    required String name,
    required String email,
    required String pass,
    required String phone,
     String image='',
  }) async
  {
    emit(RegisterLoadDataState());
    DioHelper.PostData(
      url: 'register',
      query: {
        'name':name,
        'phone':phone,
        'email':email,
        'password':pass,
        'image':image,
      },
    ).then((value) {
      userLogin=UserLogin.fromJson(value.data);
      print(userLogin?.statue);
      print(userLogin?.message);
      emit(RegisterGetDataSuccessState(userLogin!));
    }).catchError((error){
      print('error when get data ${error.toString()}');
      emit(RegisterGetDataErrorState(error.toString()));
    });

  }

}