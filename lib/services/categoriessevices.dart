import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task_manager_app/model/categories.dart';

class ApiService{
  Future<List<Category>> getCategories() async {
    final respone = await http.get(Uri.parse('https://681883345a4b07b9d1cf76be.mockapi.io/api/user/Categories'));

    if(respone.statusCode == 201 || respone.statusCode == 200){
      List<dynamic> data = json.decode(respone.body);
      return data.map((e) => Category.fromJson(e)).toList();
    }else{
      throw Exception('Failed to load categories');
    }
  }
  Future<Category> addCategory(Category category) async {
    final response = await http.post(
      Uri.parse('https://681883345a4b07b9d1cf76be.mockapi.io/api/user/Categories'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(category.toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      // MockAPI usually returns 201 on successful creation
      return Category.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add category');
    }
  }
  Future<Category> updateCategory(Category category) async {
    final response = await http.put(
      Uri.parse('https://681883345a4b07b9d1cf76be.mockapi.io/api/user/Categories/${category.id}'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(category.toJson()),
    );

    if (response.statusCode == 200) {
      return Category.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update category');
    }
  }
  Future<void> deleteCategory(String id) async {
    final response = await http.delete(
      Uri.parse('https://681883345a4b07b9d1cf76be.mockapi.io/api/user/Categories/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete category');
    }
  }
}