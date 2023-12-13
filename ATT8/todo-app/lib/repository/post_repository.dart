import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/model/todo_model.dart';

class TodoRepository {
  final String key = 'todos';

  Future<List<TodoModel>> fetchAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final todosString = prefs.getStringList(key);
    if (todosString != null) {
      final List<dynamic> todosJson = prefs.getStringList(key)!;
      return todosJson.map((json) => TodoModel.fromJson(json)).toList();
    }
    return [];
  }

  Future<void> addTodo(TodoModel todo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> todosString = prefs.getStringList(key) ?? [];
    todosString.add(json.encode(todo.toJson()));
    prefs.setStringList(key, todosString);
  }

  Future<void> updateTodo(TodoModel updatedTodo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> todosString = prefs.getStringList(key) ?? [];
    final index = todosString.indexWhere((todo) {
      final existingTodo = TodoModel.fromJson(json.decode(todo));
      return existingTodo.id == updatedTodo.id;
    });

    if (index != -1) {
      todosString[index] = json.encode(updatedTodo.toJson());
      prefs.setStringList(key, todosString);
    }
  }

  Future<void> deleteTodo(int todoId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> todosString = prefs.getStringList(key) ?? [];
    final index = todosString.indexWhere((todo) {
      final existingTodo = TodoModel.fromJson(json.decode(todo));
      return existingTodo.id == todoId;
    });

    if (index != -1) {
      todosString.removeAt(index);
      prefs.setStringList(key, todosString);
    }
  }
}
