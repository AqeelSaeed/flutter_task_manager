

import 'dart:convert';

import 'package:flutter_task_manager_app/model/error_response.dart';
import 'package:flutter_task_manager_app/model/todo.dart';
import 'package:flutter_task_manager_app/storage/save_user.dart';
import 'package:flutter_task_manager_app/utils/utils.dart';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';
import '../main.dart';
import '../model/todo_user.dart';

class Authentication {



  static Future<TodoUser> loginUser(String userName, String password) async {
    late TodoUser user;
    final uri = Uri.parse(ApiConstants.baseUrl + ApiConstants.loginUser);
    Utils.showLogs(uri);
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };
    Map<String, dynamic> body = {
      "username" : userName,
      "password" : password
    };

    try{
      final apiResponse = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(body)
      );
      Utils.showLogs(apiResponse.body);
      if(apiResponse.body.contains('Invalid credentials')){
        ErrorResponse errorResponse = ErrorResponse.fromJson(jsonDecode(apiResponse.body));
        Utils.showLogs(errorResponse.message);
        Utils.showMessages(errorResponse.message);
      }else{
        user = TodoUser.fromJson(jsonDecode(apiResponse.body));
        SaveUser.saveUser(user);
      }

    }catch(exception){
      Utils.showLogs('$exception df');
    }
    return user;

  }

  static Future<TodoUser> getCurrentUser() async{
    late TodoUser user;

    String userString = preferences.getString('user').toString();
    user = TodoUser.fromJson(jsonDecode(userString));
    Utils.showLogs('saved user: $userString');

    Map<String, String> headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
      'Authorization' : 'Bearer${user.token}'
    };

    try{
      String currentUser = 'user/me';
      final uri = Uri.parse(ApiConstants.baseUrl + currentUser);
      final response = await http.get(
        uri,
        headers: headers
      );
      Utils.showLogs(response.body);
      user = TodoUser.fromJson(jsonDecode(response.body));
      Utils.showLogs(user.firstName);
    }catch (exception){
      Utils.showLogs('Exception: $exception');
    }

    return user;
  }

}