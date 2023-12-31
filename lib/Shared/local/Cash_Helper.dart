

import 'package:shared_preferences/shared_preferences.dart';

class CashHelper
{
  static late SharedPreferences preferences;

 static initPref() async
  {
    preferences= await SharedPreferences.getInstance();
  }

 static Future<bool> PutBool({
  required String key,
    required bool value,
})  async
  {
     return await preferences.setBool(key, value);
  }

 static bool? getBool({
  required String key,
})
  {
   return preferences.getBool(key);
  }

  static Future<dynamic> saveData({
  required String key,
    required dynamic value,
}) async
  {
   if(value is bool)
     return await preferences.setBool(key, value);
   else if (value is String)
   return await preferences.setString(key, value);
   else if (value is int)
     return await preferences.setInt(key, value);
   else{
  return await preferences.setDouble(key, value);
   }

  }

  static dynamic getCash({
  required String key,
})
  {
   return  preferences.get(key);
  }

  static Future<bool?> removeData({
  required String key,
}) async
  {
  return await  preferences.remove(key);
  }
}

