import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../Layout/layout_cubit/Layout_cubit.dart';
import '../../Models/Search/Search_class.dart';
import '../../Shared/Components/component.dart';
import '../../Shared/end_Point.dart';
import 'cubit/Search_Cubit.dart';
import 'cubit/Search_State.dart';

class SearchScreen extends StatelessWidget {

  var searchControl=TextEditingController();
  var keyForm=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state)
        {
          if(state is SearchSuccessState)
            {

            }
        },
        builder: (context, state) {
          SearchCubit cubit = SearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  Form(
                    key: keyForm,
                    child: Container(
                      child: defaultForm(
                          controler: searchControl,
                          title: 'Search',
                          prefix: Icons.search,
                          type: TextInputType.text,
                          isPass: false,
                          validate: (value)
                          {
                                if(value!.isEmpty)
                                  {
                                    return 'Enter text to search';
                                  }
                                return null;
                          },
                        onSubmit: (value)
                        {
                          print(value);
                          print(getToken);
                            if(keyForm.currentState!.validate())
                              {
                                cubit.getSearch(text: value);
                              }
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  if(state is SearchLoadState)
                    LinearProgressIndicator(),

                  Container(
                    child: ConditionalBuilder(
                      condition: cubit.searchModel != null,
                      builder: (context) => ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) =>
                              SearchItem(cubit.searchModel?.searchDataModel?.searchList[index], context),
                          separatorBuilder: (context, index) =>
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 20.0,
                                ),
                                child: Container(
                                  width: double.infinity,
                                  height: 1.0,
                                  color: Colors.grey[300],
                                ),
                              ),
                          itemCount: cubit.searchModel!.searchDataModel!.searchList.length),
                      fallback: (context) => SizedBox(height: 10,),

                    ),
                  ),
                ],
              ),
            ),
          );
        },

      ),
    );
  }

  Widget SearchItem(SearchData? model, context) =>
      Container(
        height: 100.0,
        child: Row(

          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            Container(
              height: 100.0,
              width: 100.0,
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,

                children:
                [
                  Image(

                    image: NetworkImage(
                        model!.searchProducts!.image.toString()),
                    width: double.infinity,
                    height: 100.0,
                    fit: BoxFit.cover,

                  ),

                  if(model.searchProducts!.discount > 0)
                    Container(
                      color: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),


                ],
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children:
                [
                  Text(
                    '${model.searchProducts!.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      height: 1.5,

                    ),
                  ),
                  Spacer(),
                  Row(
                    children:
                    [
                      Text(
                        '${model.searchProducts!.price}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                          color: Colors.deepOrange,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      if(model.searchProducts!.discount > 0)
                        Text(
                          '${model.searchProducts!.old_price}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 10.0,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          LayoutCubit.get(context).changeFavorites(
                              FavId: model.searchProducts?.productId);
                        },
                        icon: CircleAvatar(
                          radius: 100.0,
                          backgroundColor: true
                              ? Colors.deepOrange
                              : Colors.grey,
                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                      )
                    ],
                  ),


                ],
              ),
            ),
          ],
        ),
      );
}
