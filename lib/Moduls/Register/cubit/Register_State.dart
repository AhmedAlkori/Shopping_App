import '../../../Models/Login/Login_Class.dart';

abstract class RegisterState{}
class RegisterInitState extends RegisterState{}

class RegisterChangePassState extends RegisterState{}


class RegisterLoadDataState extends RegisterState{}
class RegisterGetDataSuccessState extends RegisterState
{
  final UserLogin userLogin;
  RegisterGetDataSuccessState(this.userLogin);
}
class RegisterGetDataErrorState extends RegisterState
{
  final String error;
  RegisterGetDataErrorState(this.error);
}