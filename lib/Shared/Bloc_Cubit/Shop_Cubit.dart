import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../../Models/Login/Login_Class.dart';
import '../../Models/Page_Class.dart';
import '../local/Cash_Helper.dart';
import '../network/Dio_Helper.dart';
import 'Shop_State.dart';

class ShopCubit extends Cubit<ShopState>
{
  ShopCubit() :super(ShopInitState());

  static ShopCubit get(context)=>BlocProvider.of(context);

  var pageContoroller=PageController();
  bool isLast=false;
  bool isOnBoardingSkipped=false;
  bool isHide=true;

  bool isLogin=false;
  UserLogin? userLogin;

  List<dynamic> allLogin=[];

  List<PageClass> pages=[
    PageClass(
        pic: 'assets/images/b1.png',
        titleOne: 'CHOOSE PRODUCT',
        titleTow: 'Lorem text',
    ),
    PageClass(
      pic: 'assets/images/b2.png',
      titleOne: 'CHECK OUT AND PAY',
      titleTow: 'Lorem text',
    ),
    PageClass(
      pic: 'assets/images/b3.png',
      titleOne: 'DELIVERED',
      titleTow: 'Lorem text',
    ),
  ];

  void changeLast({
  required bool res,
})
  {
    isLast=res;
    emit(ShopChangeLastState());
  }

  void getOnBoardingStatue()
 {
   bool? res=CashHelper.getBool(key: 'isOnBoarding');
   if(res ==null)
     {
       isOnBoardingSkipped=false;

     }
   else
     {
       isOnBoardingSkipped=res;
     }
 }

 void setOnBoardingStatue()
 {
   CashHelper.PutBool(key: 'isOnBoarding', value: true).then((value) {
     print('set OnBoarding Success $value');
     emit(ShopSetOnBoardingState());
   }).catchError((error){
     print('error when putBool ${error.toString()}');
   });
 }

void changePass()
{
  isHide =!isHide;
  emit(ShopChangePassState());
}



  void MakeLogin({
    required String email,
    required String pass,
  }) async
  {
    emit(ShopLoadDataState());
    DioHelper.PostData(
        url: 'login',
        query: {
           'email':email,
           'password':pass,
        },
    ).then((value) {
  userLogin=UserLogin.fromJson(value.data);
      print(userLogin?.statue);
      print(userLogin?.message);
      emit(ShopGetDataSuccessState(userLogin!));
    }).catchError((error){
         print('error when get data ${error.toString()}');
         emit(ShopGetDataErrorState(error.toString()));
    });

  }

  void saveCash({
  required String key,
    required dynamic value,
})
  {
    CashHelper.saveData(key: key, value: value).then((value) {
      print('cash saved successfully');
    }).catchError((error){
      print('error when save cash ${error.toString()}');
    });
  }


}