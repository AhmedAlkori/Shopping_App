
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';

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



Shimmer getShimmerLoading(context)
{
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: ProductBuilder(context),
  );
}




Widget ProductBuilder(context)=>SingleChildScrollView(
  scrollDirection: Axis.vertical,
  physics: BouncingScrollPhysics(),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:
    [
      SizedBox(
        height: 10.0,
      ),
      Container(
        width: double.infinity,
        height: 200,
        color: Colors.white,
      ),

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
            Container(
              width: 100.0,
              height: 16,
              color: Colors.white,
            ),

            SizedBox(
              height: 10.0,
            ),
            Container(
              height: 100.0,
              child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index)=>CatItems(),
                  separatorBuilder: (context,state)=>SizedBox(width: 10.0,),
                  itemCount: 4),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              width: 100.0,
              height: 16,
              color: Colors.white,
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      Container(

        child: GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          mainAxisSpacing: 1.0,
          crossAxisSpacing: 1.0,
          childAspectRatio: 1/ 1.50,
          children:List.generate(
              4,
                  (index) => GridItem(context)
          ),
        ),
      ),

    ],
  ),
);

Widget GridItem(context)=>Padding(
  padding: const EdgeInsets.all(4.0),
  child: Container(

    child: Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children:
          [
            Container(
              width: double.infinity,
              height: 200,
              color: Colors.white,
            ),
            SizedBox(
              height: 10,
            ),

          ],
        ),

        Padding(
          padding:EdgeInsets.symmetric(
            horizontal: 5.0,

          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            [
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 14.0,
                color: Colors.white,
              ),
              SizedBox(
                height: 10,
              ),

              Row(
                children:
                [
                  Container(
                    width: 80,
                    height: 10.0,
                    color: Colors.white,
                  ),

                  SizedBox(
                    width: 10.0,
                  ),
                  Spacer(),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius:15,

                  ),
                ],
              ),
            ],
          ),
        ),



      ],
    ),
  ),
);




Widget CatItems()=>Stack(
  alignment: AlignmentDirectional.bottomCenter,
  children:
  [
    Container(
      width: 100.0,
      height: 100.0,
      color: Colors.white,
    ),

    Container(
      color: Colors.black.withOpacity(.6),
      width: 100.0,
      child: Container(
        width: 10,
        height: 10,
        color: Colors.white,
      ),
    ),
  ],
);




