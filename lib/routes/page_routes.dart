

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_manager_app/routes/routes.dart';
import 'package:flutter_task_manager_app/views/login_screen.dart';
import 'package:flutter_task_manager_app/views/todos_screen.dart';

class PageRoutes {

  Route<dynamic>? appRoutes (RouteSettings settings){

    switch (settings.name){
      case Routes.loginScreenRoute:
        return navigateToRoute(const LoginScreen());
      case Routes.todoScreenRoute:
        return navigateToRoute(const TodosScreen());
    }

    return null;
  }

  initialRoute(){
    return MaterialPageRoute(builder: (context) => const LoginScreen());
  }

   navigateToRoute(Widget screen){
    if(Platform.isAndroid){
      return MaterialPageRoute(builder: (context) => screen);
    }
    if(Platform.isIOS){
      return CupertinoPageRoute(builder: (context) => screen);
    }
  }

}