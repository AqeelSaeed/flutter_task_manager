

import 'package:flutter_task_manager_app/constants/api_constants.dart';
import 'package:http/http.dart' as http;

import '../utils/utils.dart';

class TodosList {

  Future<http.Response> todosResponse({required String limit, required String skip}) async{
    late http.Response response;
    final queryParams = {
      "limit" : limit,
      "skip" : skip
    };
    try{
    final uri = Uri.parse(ApiConstants.baseUrl + ApiConstants.todoList);
    final newUri = uri.replace(queryParameters: queryParams);
    Utils.showLogs(newUri);
    response = await http.get(uri);
    }catch(exception){
      Utils.showLogs(exception);
    }
    return response;
  }

}