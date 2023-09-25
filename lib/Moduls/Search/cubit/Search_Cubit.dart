import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Models/Search/Search_class.dart';
import '../../../Shared/end_Point.dart';
import '../../../Shared/network/Dio_Helper.dart';
import 'Search_State.dart';


class SearchCubit extends Cubit<SearchState>
{
  SearchCubit():super(SearchInit());

  static SearchCubit get(context)=>BlocProvider.of(context);



SearchModel? searchModel;

void getSearch({
  required String text,
})
{
  emit(SearchLoadState());
  DioHelper.PostData(
      url: 'products/search',
      token: getToken!,
      query: {
        'text':text,
      }
  ).then((value) {
   searchModel=SearchModel.fromJson(value.data);
   print(searchModel!.status);
  // print(searchModel!.searchDataModel!.searchList[0].searchProducts!.name);
   emit(SearchSuccessState(searchModel!));
  }).catchError((error){
      print('error when search ${error.toString()}');
      emit(SearchErrorState());
  });
}

}