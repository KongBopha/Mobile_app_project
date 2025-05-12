
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task_manager_app/model/task.dart';

class ApiService{
  Future<List<Task>> getTasks() async {
    final respone = await http.get(Uri.parse('https://681883345a4b07b9d1cf76be.mockapi.io/api/user/Task'),
          headers: {
        'Content-Type': 'application/json',
      },);

    if(respone.statusCode == 201 || respone.statusCode == 200){
      print('Response Body: ${respone.body}');
      final List<dynamic> data = jsonDecode(respone.body);
      return data.map((json) => Task.fromJson(json)).toList();
    }else{
      throw Exception('Failed to load tasks');
    }
  }
  Future<Task> addTask(Task task) async {
    final response = await http.post(
      Uri.parse('https://681883345a4b07b9d1cf76be.mockapi.io/api/user/Task'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(task.toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      // MockAPI usually returns 201 on successful creation
      return Task.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add task');
    }
  }
  Future<void> updateTask(Task task) async{
    final response = await http.put(
      Uri.parse('https://681883345a4b07b9d1cf76be.mockapi.io/api/user/Task/${task.id}'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(task.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update task');
    }
  }
  Future<void> deleteTask(String id) async {
    final response = await http.delete(
      Uri.parse('https://681883345a4b07b9d1cf76be.mockapi.io/api/user/Task/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete task');
    }
  }
  Future<Task> toggleTaskCompleted(Task task) async {

    final response = await http.put(
      Uri.parse('https://681883345a4b07b9d1cf76be.mockapi.io/api/user/Task/${task.id}'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(task.toJson()),
    );

    if (response.statusCode == 200) {
      return Task.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to toggle task completion');
    }
  }
}
