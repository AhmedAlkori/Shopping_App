
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Models/Page_Class.dart';


Widget onBoardingItem(PageClass model)=>Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children:
  [
    Expanded(

      child: Container(
        width: double.infinity,

        child:Image(
          image: AssetImage('${model.img}'),
          fit: BoxFit.contain,

        ),
      ),
    ),

    SizedBox(
      height: 30.0,
    ),
    Text(
      '${model.titeO}',
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 20.0,

      ),
    ),
    SizedBox(
      height: 20.0,
    ),
    Text(
      '${model.titleT}',
      style: TextStyle(

        fontSize: 16.0,


      ),
    ),
    SizedBox(
      height: 20.0,
    ),
  ],
);


void NextWidget({
  required context,
  required Widget myWidget,
})
{


  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context)=>myWidget),
          (route) => false);
}


Widget defaultForm({
  required TextEditingController controler,
  required String title,
  required IconData prefix,
  required TextInputType type,
  required bool isPass,
           bool isVisibale=true,
  required FormFieldValidator<String>? validate,
  VoidCallback? onPress,
  ValueChanged<String>? onSubmit,
})=> TextFormField(
  controller:controler,
  obscureText: isPass ?  isVisibale : false,
  keyboardType: type,
  decoration: InputDecoration(
    border: OutlineInputBorder(),
    labelText: title,
    prefixIcon: Icon(
      prefix,
    ),
    suffixIcon: isPass != true ? Icon(
      null,
    ) :IconButton(
      onPressed:onPress,
      icon:  Icon(
          isVisibale ?Icons.visibility_off : Icons.visibility ,
      ),

    ),
  ),
  validator:validate,
  onFieldSubmitted: onSubmit,

);


void ShowToast({
  required String text,
  required Color bgColor,
})=> Fluttertoast.showToast(
  msg: text,
  toastLength: Toast.LENGTH_SHORT,
  gravity: ToastGravity.BOTTOM,
  backgroundColor:bgColor ,
  textColor: Colors.white,
  fontSize: 16.0,
);



