class UserLogin
{
  bool? statue;
  String? message;
  UserData? userData;

    UserLogin.fromJson(Map<String,dynamic> json)
    {
      statue=json['status'];
      message=json['message'];
      userData=json['data'] !=null? UserData.fromJson(json['data']):null;
    }
}

class UserData
{
  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? image;
  int?    point;
  int?    credit;
  String? token;

    UserData.fromJson(Map<String,dynamic> json)
    {
      id=json['id'];
      name=json['name'];
      email=json['email'];
      phoneNumber=json['phone'];
      image=json['image'];
      point=json['points'];
      credit=json['credit'];
      token=json['token'];
    }
}