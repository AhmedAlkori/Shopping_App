import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Layout/layout_cubit/Layout_State.dart';
import '../../Layout/layout_cubit/Layout_cubit.dart';
import '../../Models/Categories/Categories_Model.dart';


class CategoryScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit,LayoutState>(
      listener: (context,state){},
      builder: (context,state)
      {
        LayoutCubit cubit=LayoutCubit.get(context);
        return  ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context,index)=>CatList(cubit.categoriesModel!.categoriesDataModel!.data[index]),
          separatorBuilder: (context,index)=> Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          itemCount: cubit.categoriesModel!.categoriesDataModel!.data.length,
        );
      },

    );
  }

  Widget CatList(CategoriesData? model)=> Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children:
      [
        Image(
          image: NetworkImage(model!.image.toString()),
          width: 80.0,
          height: 80.0,
          fit: BoxFit.cover,
        ),
        SizedBox(
          width: 10.0,
        ),
        Text(
          '${model.name}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        Spacer(),
        IconButton(
          onPressed: (){},
          icon: Icon(
            Icons.arrow_forward_ios,
          ),
        ),
      ],
    ),
  );
}
