
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_task_manager_app/model/todo.dart';
import 'package:flutter_task_manager_app/network_resources/todos_list.dart';
import 'package:flutter_task_manager_app/utils/utils.dart';

class TodoProvider extends ChangeNotifier{

  bool isLoading = false;
  List<Todo>? listOfTodos = [];
  String option = '';

  String todoLimit = '10';
  String skipTodos = '0';



  Future<List<Todo>> todosList() async{
    isLoading = true;
    notifyListeners();
    final response = await TodosList().todosResponse(limit: todoLimit, skip: skipTodos);
    Todos todos = Todos.fromJson(jsonDecode(response.body));
    listOfTodos = todos.todos!;
    Utils.showLogs(listOfTodos);
    isLoading = false;
    notifyListeners();
    return listOfTodos ?? [];
  }


  updateOptionsValue(String value){
    option = value;
    Utils.showMessages(option);
    notifyListeners();
  }

}