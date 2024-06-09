
import 'package:flutter/material.dart';
import 'package:flutter_task_manager_app/constants/api_constants.dart';
import 'package:flutter_task_manager_app/controller/providers/todo_provider.dart';
import 'package:flutter_task_manager_app/utils/enums.dart';
import 'package:flutter_task_manager_app/utils/utils.dart';
import 'package:provider/provider.dart';

import '../constants/text_constants.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({super.key});

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {

  @override
  void initState() {
    super.initState();
    
    Future.microtask((){
      final TodoProvider todoProvider = context.read<TodoProvider>();
      todoProvider.todosList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<TodoProvider>(builder: (context, todo, child){
            return todo.isLoading ?
                const Center(
                  child: CircularProgressIndicator(
                    color: Colors.teal,
                    strokeCap: StrokeCap.round,
                  ),
                )
                : Expanded(
              child: ListView.builder(
                  itemCount: todo.listOfTodos!.length,
                  itemBuilder: (context, index){
                    return Container(
                      height: 100,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 8,
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 10
                            )
                          ]
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  todo.listOfTodos![index].todo.toString(),
                                ),
                                Text(todo.listOfTodos![index].completed.toString())
                              ],
                            ),
                          ),

                          PopupMenuButton(
                            onSelected: (value) {
                              todo.updateOptionsValue(value.name);
                            },
                            itemBuilder: (BuildContext bc) {
                              return const [
                                PopupMenuItem(
                                  child: Text(TextConstants.edit),
                                  value: MenuOptions.edit,
                                ),
                                PopupMenuItem(
                                  child: Text(TextConstants.delete),
                                  value: MenuOptions.delete,
                                ),
                              ];
                            },
                          )
                        ],
                      ),
                    );
                  }),
            );
          })
        ],
      ),
    );
  }
}
