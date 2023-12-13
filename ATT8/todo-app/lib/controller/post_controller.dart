import 'package:flutter/material.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/repository/todo_repository.dart';

class HomeController {
  List<TodoModel> todos = [];
  final repository = TodoRepository();
  final state = ValueNotifier<HomeState>(HomeState.start);

  Future<void> start() async {
    state.value = HomeState.loading;
    try {
      todos = await repository.fetchAll();
      state.value = HomeState.success;
    } catch (e) {
      state.value = HomeState.error;
    }
  }
    void addTodo(TodoModel todo) {
    todos.add(todo);
    // Adicione qualquer lógica adicional para persistir os dados ou atualizar a interface.
  }
  
  void removeTodo(TodoModel todo) {
    todos.removeWhere((element) => element.id == todo.id);
    // Adicione qualquer lógica adicional para persistir os dados ou atualizar a interface.
  }
  void editTodo(TodoModel updatedTodo) {
    final index = todos.indexWhere((todo) => todo.id == updatedTodo.id);
    if (index != -1) {
      todos[index] = updatedTodo;
      // Adicione qualquer lógica adicional para persistir os dados ou atualizar a interface.
    }
  }

}

enum HomeState { start, loading, success, error }
