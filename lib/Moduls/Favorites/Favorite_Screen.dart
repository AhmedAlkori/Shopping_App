import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Layout/layout_cubit/Layout_State.dart';
import '../../Layout/layout_cubit/Layout_cubit.dart';
import '../../Models/Favorites_Model/Fav_Model.dart';


class FavoriteScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        LayoutCubit cubit = LayoutCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: ConditionalBuilder(
            condition: state is! LayoutLoadFavState,
            builder: (context) =>
                ConditionalBuilder(
                    condition: cubit.favoritesModel!.favoritesDataModel!
                        .favoriteList.length > 0,
                    builder: (context) =>
                        ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) =>
                                FavItem(cubit.favoritesModel?.favoritesDataModel
                                    ?.favoriteList[index], context),
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
                            itemCount: cubit.favoritesModel!.favoritesDataModel!
                                .favoriteList.length),
                    fallback: (context) =>
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                            Center(
                              child: Container(

                                child: Icon(
                                  Icons.menu,
                                  size: 100.0,
                                  color: Colors.grey,
                                ),

                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              'No Favorites Yet, Please Add Some Favorites',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        )),
            fallback: (context) => Center(child: CircularProgressIndicator()),

          ),
        );
      },

    );
  }

  Widget FavItem(FavoritesData? model, context) =>
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
                        model!.favoriteProducts!.image.toString()),
                    width: double.infinity,
                    height: 100.0,
                    fit: BoxFit.cover,

                  ),

                  if(model.favoriteProducts!.discount > 0)
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
                    '${model.favoriteProducts!.name}',
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
                        '${model.favoriteProducts!.price}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                          color: Colors.deepOrange,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      if(model.favoriteProducts!.discount > 0)
                        Text(
                          '${model.favoriteProducts!.old_price}',
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
                              FavId: model.favoriteProducts?.productId);
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
