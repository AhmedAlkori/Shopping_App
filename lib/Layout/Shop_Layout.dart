import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Moduls/Search/Search_Screen.dart';
import 'layout_cubit/Layout_State.dart';
import 'layout_cubit/Layout_cubit.dart';


class ShopLayout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>LayoutCubit()..getHome()..getCategories()..getFavorites()..getProfile(),
      child: BlocConsumer<LayoutCubit,LayoutState>(
        listener: (context,state){},
        builder:(context,state)
        {
          LayoutCubit cubit=LayoutCubit.get(context);
          return  Scaffold(
            appBar: AppBar(
              title: Text(
                'Salla Shop',
                style: TextStyle(
                  fontFamily: 'Janna'
                ),
              ),
              actions:
              [
                IconButton(
                    onPressed: ()
                    {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>SearchScreen()));
                    },
                    icon: Icon(
                      Icons.search,
                    )),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index)
              {
                 cubit.changeBottomNavIndex(index: index);
              },
              items:
              [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                    ),
                    label: 'Home'
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.apps,
                    ),
                    label: 'Categories'
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.favorite,
                    ),
                    label: 'Favorites'
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.settings,
                    ),
                    label: 'Settings'
                ),
              ],
            ),

          );
        } ,

      ),
    );
  }
}
