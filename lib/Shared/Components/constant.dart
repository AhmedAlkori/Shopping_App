import 'dart:ui';

import 'package:flutter/material.dart';

Color getColor(ColorState state)
{
     Color myColor;
     switch(state)
     {
       case ColorState.Success:
         myColor=Colors.green;
         break;
       case ColorState.Warning:
         myColor=Colors.amberAccent;
         break;
       case ColorState.Error:
         myColor=Colors.red;
         break;
     }
     return myColor;
}

enum ColorState {
  Success,
  Error,
  Warning
}