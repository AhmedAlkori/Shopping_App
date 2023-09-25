

import '../../Models/Login/Login_Class.dart';

abstract class ShopState{}

class ShopInitState extends ShopState{}

class ShopChangeLastState extends ShopState{}

class ShopSetOnBoardingState extends ShopState{}

class ShopChangePassState extends ShopState{}

class ShopLoadDataState extends ShopState{}
class ShopGetDataSuccessState extends ShopState
{
  final UserLogin userLogin;
  ShopGetDataSuccessState(this.userLogin);
}
class ShopGetDataErrorState extends ShopState
{
  final String error;
  ShopGetDataErrorState(this.error);
}
