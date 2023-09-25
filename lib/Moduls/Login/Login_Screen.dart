import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




import '../../Layout/Shop_Layout.dart';
import '../../Shared/Bloc_Cubit/Shop_Cubit.dart';
import '../../Shared/Bloc_Cubit/Shop_State.dart';
import '../../Shared/Components/component.dart';
import '../../Shared/Components/constant.dart';
import '../Register/Register_Screen.dart';

class LoginScreen extends StatelessWidget {

     var emailControl=TextEditingController();
     var passControl=TextEditingController();
      var keyForm=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> ShopCubit(),
      child: BlocConsumer<ShopCubit,ShopState>(
        listener: (context,state)
        {
            if(state is ShopGetDataSuccessState)
              {
                if(state.userLogin.statue == true)
                  {
                    print(state.userLogin.userData?.token);
                    ShopCubit.get(context).saveCash(key: 'tokenLogin', value: state.userLogin.userData?.token);
                    NextWidget(
                        context: context,
                        myWidget: ShopLayout());
                    ShowToast(
                        text: state.userLogin.message.toString(),
                        bgColor: getColor(ColorState.Success),
                    );
                  }
                else
                  {
                    ShowToast(
                      text: state.userLogin.message.toString(),
                      bgColor: getColor(ColorState.Warning),
                    );
                  }

              }
            else
              {
                if(state is ShopGetDataErrorState)
                  {
                    ShowToast(
                      text: state.error,
                      bgColor: getColor(ColorState.Warning),
                    );

                  }
              }
        },
        builder: (context,state)
        {

          ShopCubit cubit=ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child:  Form(
                    key: keyForm,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 26.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style: TextStyle(

                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          child:  defaultForm(
                            controler: emailControl,
                            title: 'Email Address',
                            prefix: Icons.email_outlined,
                            type: TextInputType.emailAddress,
                            isPass: false,
                            validate: (value)
                            {
                              if(value?.isEmpty== true)
                                {
                                  return 'Email Address must be not empty';
                                }
                              else
                              {
                                return null;
                              }
                            }
                          ),
                        ),

                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          child: defaultForm(
                            controler: passControl,
                            title: 'Password',
                            prefix: Icons.lock,
                            type: TextInputType.visiblePassword,
                            isPass: true,
                            isVisibale: cubit.isHide,
                            onPress: ()
                            {
                              cubit.changePass();
                            },
                              validate: (value)
                              {
                                if(value?.isEmpty== true)
                                {
                                  return 'Sorry ! , Password is too short';
                                }
                                else
                                {
                                  return null;
                                }
                              },
                            onSubmit: (value)
                            {
                              if(keyForm.currentState!.validate())
                                {
                                  cubit.MakeLogin(
                                      email: emailControl.text,
                                      pass:passControl.text);
                                }
                            }

                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),

                          ConditionalBuilder(
                            condition: state is ShopLoadDataState ,
                            builder:(context)=> Center(child: CircularProgressIndicator()),
                            fallback: (context)=>  Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.deepOrange,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: MaterialButton(
                                onPressed: ()
                                {

                                  if(keyForm.currentState!.validate())
                                  {
                                    cubit.MakeLogin(
                                        email: emailControl.text,
                                        pass: passControl.text);


                                  }
                                  else
                                  {

                                  }
                                },
                                child: Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.0,
                                  ),

                                ),
                              ),
                            ),
                          ),



                        SizedBox(
                          height: 20.0,
                        ),

                        Row(

                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                            Text(
                              'Dont\'t have an account?',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            TextButton(
                                onPressed: ()
                                {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context)=>RegisterScreen()));
                                },
                                child: Text(
                                  'REGISTER',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                            ),
                          ],
                        ),



                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },

      ),
    );
  }
}
