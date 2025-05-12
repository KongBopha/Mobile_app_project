import 'package:flutter/material.dart';
import 'package:task_manager_app/model/task.dart';
import 'package:task_manager_app/services/taskservices.dart';

class TaskProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  final List<Task> _tasks = [];
  bool _isLoading = false;

  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;

  //get all tasks from the API
Future<void> getPost() async {
  _isLoading = true;
  notifyListeners();
  try {
    final fetchedTasks = await _apiService.getTasks();
    _tasks.addAll(fetchedTasks);   
    print('Fetched tasks: $_tasks');
  } catch (e) {
    print("Error fetching tasks: $e");
  }
  _isLoading = false;
  notifyListeners();
}
  //add a task to the API
  Future<void> addTask(Task task) async{
    _isLoading = true;
    notifyListeners();
    
    try {
      await _apiService.addTask(task);
      _tasks.add(task);
    } catch (e) {
      print("Error adding task: $e");
    }
    _isLoading = false;
    notifyListeners();
  }

  //update a task in the API
  Future<void> updateTask(Task task) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      await _apiService.updateTask(task);
      int index = _tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        _tasks[index] = task;
      }
    } catch (e) {
      print("Error updating task: $e");
    }
    _isLoading = false;
    notifyListeners();
  }
  //delete a task from the API
  Future<void> deleteTask(String id) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      await _apiService.deleteTask(id);
      _tasks.removeWhere((task) => task.id == id);
    } catch (e) {
      print("Error deleting task: $e");
    }
    _isLoading = false;
    notifyListeners();
  }
  //toggle task completed status
  Future<void> toggleTaskCompleted(task) async {
    _isLoading = true;
    notifyListeners();
    try {
      int taskIndex = _tasks.indexOf(task);
      await _apiService.toggleTaskCompleted(task);
      if (taskIndex != -1) {
        _tasks[taskIndex].isCompleted = !_tasks[taskIndex].isCompleted;
        _apiService.updateTask(_tasks[taskIndex]);
      }
    } catch (e) {
      print("Error toggling task completed status: $e");
    }
    _isLoading = false;
    notifyListeners();
  } 
}
