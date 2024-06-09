

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_task_manager_app/model/todo_user.dart';
import 'package:flutter_task_manager_app/network_resources/authentication.dart';
import 'package:flutter_task_manager_app/utils/utils.dart';

class AuthProvider extends ChangeNotifier{

  bool isLoading = false;
  late TodoUser user;

  Future<void> saveUser(String userName, String password) async{
    isLoading = true;
    notifyListeners();

    user = await Authentication.loginUser(userName, password);
    Utils.showLogs(jsonEncode(user));

    isLoading = false;
    notifyListeners();

  }


}