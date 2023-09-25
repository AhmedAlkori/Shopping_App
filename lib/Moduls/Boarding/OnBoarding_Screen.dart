import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../Shared/Bloc_Cubit/Shop_Cubit.dart';
import '../../Shared/Bloc_Cubit/Shop_State.dart';
import '../../Shared/Components/component.dart';
import '../../Shared/Components/component.dart';
import '../Login/Login_Screen.dart';

class onBoardingScreen extends StatelessWidget {





  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext context)=>ShopCubit(),
      child: BlocConsumer<ShopCubit,ShopState>(
        listener: (context,state){},
        builder: (context,state)
        {
          ShopCubit cubit=ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              actions:
              [
                TextButton(
                  onPressed: ()
                  {
                    cubit.saveCash(key: 'onBoarding', value: true);
                    NextWidget(
                        context: context,
                        myWidget: LoginScreen());
                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      fontFamily: 'Janna',
                      color: HexColor('f27287'),
                    ),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  Expanded(
                    child: PageView.builder(

                      controller:cubit.pageContoroller,
                      onPageChanged: (index)
                      {
                          if(index == cubit.pages.length-1)
                            {
                              cubit.changeLast(res: true);
                            }
                          else
                            {
                              cubit.changeLast(res: false);
                            }
                      },
                      physics: BouncingScrollPhysics(),


                      itemBuilder: (context,index)=>onBoardingItem(cubit.pages[index]),
                      itemCount: cubit.pages.length,

                    ),
                  ),

                  Row(
                    children:
                    [
                      SmoothPageIndicator(
                        controller: cubit.pageContoroller,
                        count: 3,
                        effect: ExpandingDotsEffect(
                          activeDotColor: HexColor('f27287'),
                          dotColor: Colors.grey,
                          dotHeight: 10.0,
                          dotWidth: 10.0,
                          expansionFactor: 4.0,
                          spacing: 5.0,
                        ),
                      ),
                      Spacer(),
                      FloatingActionButton(
                        backgroundColor: HexColor('f27287'),
                        onPressed: ()
                        {
                          if (cubit.isLast)
                            {

                               cubit.saveCash(key: 'onBoarding', value: true);
                              NextWidget(
                                  context: context,
                                  myWidget: LoginScreen());
                            }
                          else
                            {
                              cubit.pageContoroller.nextPage(
                                duration: Duration(
                                  milliseconds: 500,

                                ),
                                curve: Curves.ease,
                              );
                            }

                        },
                        child: Icon(
                            Icons.arrow_forward_ios_rounded
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),

          );
        },

      ),
    );
  }

}
