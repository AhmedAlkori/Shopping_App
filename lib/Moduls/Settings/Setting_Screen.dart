import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../../Layout/layout_cubit/Layout_State.dart';
import '../../Layout/layout_cubit/Layout_cubit.dart';
import '../../Shared/Bloc_Cubit/Shop_Cubit.dart';
import '../../Shared/Components/component.dart';
import '../../Shared/Components/constant.dart';
import '../Login/Login_Screen.dart';

class SettingScreen extends StatelessWidget {
  var emailControl=TextEditingController();
  var nameControl=TextEditingController();
  var keyForm=GlobalKey<FormState>();
  var phoneControl=TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<LayoutCubit,LayoutState>(
      listener: (context,state)
      {
        if(state is SettingsUpdateProfieSuccessState)
          {
            ShowToast(
                text: state.message,
                bgColor: getColor(ColorState.Success),);
          }
        else if(state is SettingsUpdateProfieWarningState)
          {
            ShowToast(
              text: state.message,
              bgColor: getColor(ColorState.Warning),);
          }
        else
          {

          }
      },
      builder: (context,state)
      {
        var cubit=LayoutCubit.get(context);
         if(cubit.userLogin != null)
           {
             nameControl.text=cubit.userLogin!.userData!.name!;
             emailControl.text=cubit.userLogin!.userData!.email!;
             phoneControl.text=cubit.userLogin!.userData!.phoneNumber!;
           }

      return   Padding(
        padding: const EdgeInsets.all(20.0),
        child: ConditionalBuilder(
          condition: cubit.userLogin != null,
          builder: (context)=> SingleChildScrollView(
        child: Form(
          key: keyForm,
          child: Column(
          mainAxisSize: MainAxisSize.min,
            children:
            [
              if(state is SettingsUpdateProfieLoadState)
              LinearProgressIndicator(),
              SizedBox(
                height: 25.0,
              ),
              Container(
                child: defaultForm(
                  controler: nameControl,
                  title: 'Name',
                  prefix: Icons.account_circle,
                  type: TextInputType.text,
                  isPass: false,
                  onPress: ()
                  {

                  },
                  validate: (value)
                  {
                    if(value?.isEmpty== true)
                    {
                      return 'User Name must be not null';
                    }
                    else
                    {
                      return null;
                    }
                  },
                  onSubmit: (value)
                  {

                  },

                ),
              ),
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


              SizedBox(
                height: 30.0,
              ),
              Container(
                child:  defaultForm(
                    controler: phoneControl,
                    title: 'Phone Number',
                    prefix: Icons.phone,
                    type: TextInputType.number,
                    isPass: false,
                    validate: (value)
                    {
                      if(value?.isEmpty== true)
                      {
                        return 'Phone Number must be not empty';
                      }
                      else
                      {
                        return null;
                      }
                    }
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                color: Colors.deepOrange,
                width: double.infinity,
                child: MaterialButton(
                  onPressed: ()
                  {

                    if(keyForm.currentState!.validate())
                    {
                     cubit.updateProfile(
                         name: nameControl.text,
                         email: emailControl.text,
                         phone: phoneControl.text,
                     );
                    }
                    else
                    {

                    }
                  },
                  child: Text(
                    'UPDATE',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0,
                    ),

                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                color: Colors.deepOrange,
                width: double.infinity,
                child: MaterialButton(
                  onPressed: ()
                  {

                    if(keyForm.currentState!.validate())
                    {
                      cubit.removeCash(key: 'tokenLogin');
                      NextWidget(context: context, myWidget: LoginScreen());
                    }
                    else
                    {

                    }
                  },
                  child: Text(
                    'LOGOUT',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0,
                    ),

                  ),
                ),
              ),
            ],
          ),
        ),
      ),
          fallback: (context)=>Center(child: CircularProgressIndicator())),
      );
      },

    );
  }
}
