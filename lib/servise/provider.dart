import 'package:flutter/material.dart';
import 'package:todo/model/model_class.dart';
import 'package:todo/servise/db_helper.dart';

class TodoProvider with ChangeNotifier {
  final DbHelper _dbHelper = DbHelper();

  List<ModelClass> _todos = [];
  List<ModelClass> get todos => _todos;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Load all todos
  Future<void> loadTodos() async {
    _isLoading = true;
    notifyListeners();

    try {
      _todos = await _dbHelper.readData();
    } catch (e) {
      print('Error loading todos: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add new todo
  Future<void> addTodo(ModelClass todo) async {
    await _dbHelper.insertData(todo);
    await loadTodos(); 
  }

  // Delete todo
  Future<void> deleteTodo(int id) async {
    await _dbHelper.deleteData(id);
    await loadTodos(); 
  }
}
