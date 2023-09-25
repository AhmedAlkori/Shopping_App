import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




import '../../Layout/Shop_Layout.dart';
import '../../Shared/Bloc_Cubit/Shop_Cubit.dart';
import '../../Shared/Components/component.dart';
import '../../Shared/Components/constant.dart';
import '../../Shared/end_Point.dart';
import 'cubit/Register_Cubit.dart';
import 'cubit/Register_State.dart';

class RegisterScreen extends StatelessWidget {

  var emailControl=TextEditingController();
  var passControl=TextEditingController();
  var nameControl=TextEditingController();
  var phoneControl=TextEditingController();
  var keyForm=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterState>(
        listener: (context,state)
        {

          if(state is RegisterGetDataSuccessState)
          {
            if(state.userLogin.statue == true)
            {
              print(state.userLogin.userData?.token);
              getToken=state.userLogin.userData?.token;

              ShopCubit.get(context).saveCash(key: 'tokenLogin', value: getToken);
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
            if(state is RegisterGetDataErrorState)
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

          RegisterCubit cubit=RegisterCubit.get(context);
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
                          'REGISTER',
                          style: TextStyle(
                            fontSize: 26.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: TextStyle(

                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.grey,
                          ),
                        ),
                        //user name field
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          child:  defaultForm(
                              controler: nameControl,
                              title: 'User Name',
                              prefix: Icons.account_circle,
                              type: TextInputType.text,
                              isPass: false,
                              validate: (value)
                              {
                                if(value?.isEmpty== true)
                                {
                                  return 'User Name must be not empty';
                                }
                                else
                                {
                                  return null;
                                }
                              }
                          ),
                        ),
                        //email field
                        SizedBox(
                          height: 10.0,
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
                        //password filed
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

                              }

                          ),
                        ),
                        //phone number field
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          child:  defaultForm(
                              controler: phoneControl,
                              title: 'Phone',
                              prefix: Icons.phone,
                              type: TextInputType.phone,
                              isPass: false,
                              validate: (value)
                              {
                                if(value?.isEmpty== true)
                                {
                                  return 'Phone number must be not empty';
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
                                  cubit.MakeRegister(
                                      name: nameControl.text,
                                      email: emailControl.text,
                                      pass: passControl.text,
                                      phone: phoneControl.text,
                                  );
                               }
                            }
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),

                        ConditionalBuilder(
                          condition: state is RegisterLoadDataState ,
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

                                  if(keyForm.currentState!.validate())
                                  {
                                    cubit.MakeRegister(
                                      name: nameControl.text,
                                      email: emailControl.text,
                                      pass: passControl.text,
                                      phone: phoneControl.text,
                                    );
                                  }

                                }
                                else
                                {

                                }
                              },
                              child: Text(
                                'REGISTER',
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
