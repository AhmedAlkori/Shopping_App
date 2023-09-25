import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Layout/layout_cubit/Layout_State.dart';
import '../../Layout/layout_cubit/Layout_cubit.dart';
import '../../Models/Categories/Categories_Model.dart';
import '../../Models/Home_Model/HomeModel.dart';


class ProductScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit,LayoutState>(
      listener: (context,state){},
      builder: (context,state)
      {
        LayoutCubit cubit=LayoutCubit.get(context);


        return ConditionalBuilder(
            condition: cubit.homeModel != null && cubit.categoriesModel !=null,
            builder: (context)=> ProductBuilder(cubit.homeModel,cubit.categoriesModel,context),
            fallback:(context)=> Center(child: CircularProgressIndicator()),
        );
      },

    );
  }

  Widget ProductBuilder(HomeModel? model,CategoriesModel? cat,context)=>SingleChildScrollView(
    scrollDirection: Axis.vertical,
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        SizedBox(
          height: 10.0,
        ),
        CarouselSlider(
            items: model?.data?.banners.map((e) => Image(
              image: NetworkImage('${e.image}'),
              width: double.infinity,
              fit: BoxFit.cover,
            )).toList(),
            options: CarouselOptions(
              height: 250.0,
              initialPage: 0,
              enableInfiniteScroll: false,
              reverse: false,
              autoPlay: true,
              viewportFraction: 1.0,
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayInterval: Duration(seconds: 3),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            )),
        SizedBox(
          height: 10.0,
        ),
         Padding(
           padding: const EdgeInsets.symmetric(
             horizontal: 10.0,
           ),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children:
             [
                Text(
                  'Categories',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 24.0,

                  ),
                ),
               SizedBox(
                 height: 10.0,
               ),
               Container(
                 height: 100.0,
                 child: ListView.separated(
                     physics: BouncingScrollPhysics(),
                     scrollDirection: Axis.horizontal,
                     itemBuilder: (context,index)=>CatItems(cat!.categoriesDataModel!.data[index]),
                     separatorBuilder: (context,state)=>SizedBox(width: 10.0,),
                     itemCount: cat!.categoriesDataModel!.data.length),
               ),
               SizedBox(
                 height: 10.0,
               ),
               Text(
                 'New Products',
                 style: TextStyle(
                   fontWeight: FontWeight.w800,
                   fontSize: 24.0,

                 ),
               ),
             ],
           ),
         ),
         Container(
            color: Colors.grey[300],
            child: GridView.count(
                crossAxisCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              childAspectRatio: 1/ 1.70,
              children:List.generate(
                   model!.data!.products.length,
                         (index) => GridItem(model.data!.products[index],context)
                  ),
            ),
          ),

      ],
    ),
  );

  Widget GridItem(ProductModel? model,context)=>Container(
    color: Colors.white,
    child: Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children:
          [
            Image(

                image: NetworkImage(model!.image.toString()),
                width: double.infinity,
                height: 200.0,

              ),

            if(model.discount >0)
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

        Padding(
            padding:EdgeInsets.symmetric(
              horizontal: 10.0,

            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                 Text(
                    '${model.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                      fontSize: 14.0,
                    ),

                  ),

                Row(
                  children:
                  [
                    Text(
                      '${model.price}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                        color: Colors.deepOrange,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    if(model.discount>0)
                    Text(
                      '${model.old_price}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 10.0,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: ()
                      {
                        LayoutCubit.get(context).changeFavorites(FavId: model.id);
                      },
                      icon: CircleAvatar(
                        radius: 100.0,
                        backgroundColor: LayoutCubit.get(context).favoritesMap[model.id]==true
                            ? Colors.deepOrange
                            : Colors.grey ,
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

  Widget CatItems(CategoriesData? model)=>Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children:
    [
      Image(
        image:NetworkImage(model!.image.toString()),
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      ),
      Container(
        color: Colors.black.withOpacity(.6),
        width: 100.0,
        child: Text(
          '${model.name}',
          maxLines: 1,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}

