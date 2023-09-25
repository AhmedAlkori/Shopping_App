import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../Models/Categories/Categories_Model.dart';
import '../../Models/Favorites_Model/Fav_Model.dart';
import '../../Models/Home_Model/HomeModel.dart';
import '../../Models/Login/Login_Class.dart';
import '../../Moduls/Category/Category_Screen.dart';
import '../../Moduls/Favorites/Favorite_Screen.dart';
import '../../Moduls/Products/Products_Screen.dart';
import '../../Moduls/Settings/Setting_Screen.dart';
import '../../Shared/end_Point.dart';
import '../../Shared/local/Cash_Helper.dart';
import '../../Shared/network/Dio_Helper.dart';
import 'Layout_State.dart';


class LayoutCubit extends Cubit<LayoutState>
{
  LayoutCubit():super(LayoutInitState());

  static LayoutCubit get(context)=>BlocProvider.of(context);

    int currentIndex=0;

    List<Widget>screens=
    [
      ProductScreen(),
      CategoryScreen(),
      FavoriteScreen(),
      SettingScreen(),
    ];


    void changeBottomNavIndex({
  required int index,
})
    {
      currentIndex=index;
      emit(LayoutChangeNavState());
    }

    HomeModel? homeModel;
    Map<int?,bool?> favoritesMap={};

    void getHome()
    {
      emit(LayoutLoadBannersState());
      DioHelper.getData(
          url: Home,
          token:getToken ).then((value)
      {
       homeModel=HomeModel.fromJson(value.data);
       print(homeModel?.status);
       if(homeModel?.status == true)
         {
           homeModel!.data!.products.forEach((element)
           {
             favoritesMap.addAll({
               element.id:element.in_favorites,
             });
           });
         }

       emit(LayoutSuccessBannerState());
      }).catchError((error){
        print('error when get home data ${error.toString()}');
        emit(LayoutErrorBannerState());
      });
    }

    CategoriesModel? categoriesModel;
    void getCategories()
    {
      emit(LayoutLoadCategoriesState());
      DioHelper.getData(url: GET_Categories).then((value) {
        categoriesModel=CategoriesModel.fromJson(value.data);
        emit(LayoutSuccessCategoriesState());

      }).catchError((error){
        print('error when get categories ${error.toString()}');
        emit(LayoutErrorCategoriesState());
      });
    }
   String? message;
    bool? status;
    void changeFavorites({
  required int? FavId,
})
    {
      favoritesMap[FavId]= !favoritesMap[FavId]!;
      emit(LayoutLoadChangeFavIconState());
      DioHelper.PostData(url: GET_Favorites,
          query: {
        'product_id':FavId,
          },
        token: getToken!,
      ).then((value) {
        status=value.data['status'];
        if(status == true)
          {
            getFavorites();
            emit(LayoutChangeFavIconState());
          }
        else
        {
          favoritesMap[FavId]= !favoritesMap[FavId]!;
          emit(LayoutLoadChangeFavIconState());
        }
      }).catchError((error){
          print('error when modify favorites ${error.toString()}');
          favoritesMap[FavId]= !favoritesMap[FavId]!;
          emit(LayoutLoadChangeFavIconState());

      });

    }

    FavoritesModel? favoritesModel;
    void getFavorites()
    {
      emit(LayoutLoadFavState());
      DioHelper.getData(
          url: GET_Favorites,
          token: getToken,
      ).then((value) {
           favoritesModel=FavoritesModel.fromJson(value.data);
           print(favoritesModel?.status);

           emit(LayoutSuccessFavoritesState());
      }).catchError((error){
           print('error when get favorites ${error.toString()}');
           emit(LayoutErrorFavoritesState());
      });
    }




  UserLogin? userLogin;
  void getProfile()
  {
    emit(SettingsLoadDataState());
    DioHelper.getData(
        url: GET_Profile,
        token:getToken ).then((value)
    {
      userLogin=UserLogin.fromJson(value.data);
      print(userLogin?.statue);

      emit(SettingsGetDataSuccessState());
    }).catchError((error){
      print('error when get user profile data ${error.toString()}');
      emit(SettingsGetDataErrorState());
    });
  }


  void removeCash({
  required String key,
})
  {
    CashHelper.removeData(key: key).then((value) {

    }).catchError((error){

    });
  }


   String profileMessage='';
  bool profileStatues=false;
  void updateProfile({
  required String name,
    required String email,
    required String phone,
})
  {
    emit(SettingsUpdateProfieLoadState());
   DioHelper.PutData(
       url: Update_Profile,
       query: {
         'name':name,
         'phone':phone,
         'email':email,
       },
       token: getToken!,
   ).then((value) {
    profileMessage=value.data['message'];
    profileStatues=value.data['status'];
    print(profileMessage);
    if(profileStatues == true)
      {
        getProfile();
        emit(SettingsUpdateProfieSuccessState(profileMessage));
      }
    else
      {
        emit(SettingsUpdateProfieWarningState(profileMessage));
      }
   }).catchError((error){
     print('error when update profile ${error.toString()}');
     emit(SettingsUpdateProfieErrorState());
   });
  }

}