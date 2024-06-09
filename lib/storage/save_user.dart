

import 'dart:convert';

import 'package:flutter_task_manager_app/model/todo_user.dart';

import '../main.dart';
import '../utils/utils.dart';


abstract class SaveUser {


  static saveUser(TodoUser user){
    Utils.showLogs('${jsonEncode(user)}hello');
    preferences.setString('user', jsonEncode(user));
    Utils.showLogs('userPrefs: ${preferences.getString('user')}');
  }



}