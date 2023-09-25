import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';


import 'Layout/Shop_Layout.dart';
import 'Moduls/Boarding/OnBoarding_Screen.dart';
import 'Moduls/Login/Login_Screen.dart';
import 'Shared/Bloc_Cubit/Bloc_Observer.dart';
import 'Shared/Bloc_Cubit/Shop_Cubit.dart';
import 'Shared/Bloc_Cubit/Shop_State.dart';
import 'Shared/end_Point.dart';
import 'Shared/local/Cash_Helper.dart';
import 'Shared/network/Dio_Helper.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await CashHelper.initPref();
  DioHelper.initDio();
  Bloc.observer=MyBlocObserver();
  HttpOverrides.global = MyHttpOverrides();
  bool? getBoard=CashHelper.getCash(key: 'onBoarding');
  getToken=CashHelper.getCash(key: 'tokenLogin');
  print(getToken);
  Widget MainScreen;

  if(getBoard != null)
  {
    if(getToken != null)
    {
      MainScreen=ShopLayout();
    }
    else
    {
      MainScreen=LoginScreen();
    }
  }
  else
  {
    MainScreen=onBoardingScreen();
  }

  runApp( MyApp(getBoard,MainScreen));

}
class MyApp extends StatelessWidget{

  bool? onBoard;
  Widget screen;
  MyApp(this.onBoard,this.screen);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context){
        if(onBoard == null)
        {
          onBoard=false;
        }
        return ShopCubit();
      },
      child: BlocConsumer<ShopCubit,ShopState>(
        listener: (context,state){},
        builder: (context,state){

          ShopCubit cubit=ShopCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Janna',

              scaffoldBackgroundColor: Colors.white,
              primarySwatch: Colors.deepOrange,
              appBarTheme: AppBarTheme(
                color: Colors.white,
                elevation: 0.0,
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                ),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor:Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),


              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                showUnselectedLabels: true,
                elevation: 30.0,
              ),

            ),


            home: screen,

          );
        },

      ),
    );
  }

}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}