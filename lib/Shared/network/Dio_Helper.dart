import 'dart:convert';

import 'package:dio/dio.dart';

class DioHelper
{


  static late Dio dio;

  static initDio()
  {
    dio=Dio(
      BaseOptions(
        baseUrl:'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

 static Future<Response> PostData({
  required String url,
    required Map<String,dynamic> query,
   String token='',
}) async
  {
    dio.options.headers={
      'Content-Type':'application/json',
      'lang':'en',
      'Authorization': token,

    };
   return await dio.post(url,queryParameters: query);
  }
  static Future<Response> PutData({
    required String url,
    required Map<String,dynamic> query,
   required String token,
  }) async
  {
    dio.options.headers={
      'Content-Type':'application/json',
      'lang':'ar',
      'Authorization': token,

    };
    return await dio.put(url,queryParameters: query);
  }



  static Future<Response> getData({
  required String url,
    Map<String,dynamic>? query,
    String? token,
}) async
  {
    dio.options.headers={
      'Content-Type':'application/json',
      'lang':'en',
      'Authorization': token,
    };
    return await dio.get(url);
  }
}