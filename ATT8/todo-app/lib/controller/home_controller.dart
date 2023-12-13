import 'package:flutter/material.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/repository/todo_repository.dart';

class HomeController {
  List<TodoModel> todos = [];
  final repository = TodoRepository();
  final state = ValueNotifier<HomeState>(HomeState.start);

  Future start() async {
    state.value = HomeState.loading;
    try {
      todos = await repository.fetchAll();
      state.value = HomeState.success;
    } catch (e) {
      state.value = HomeState.error;
    }
  }

  void removeTodo(Todo todo) {
    todos.remove(todo);
    // Adicione qualquer lógica adicional para persistir os dados ou atualizar a interface.
  }
}

enum HomeState { start, loading, success, error}


class Todo {
  String? title;
  bool completed;

  Todo({
    this.title,
    this.completed = false,
  });
}