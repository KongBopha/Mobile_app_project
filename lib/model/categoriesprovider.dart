import 'package:flutter/material.dart';
import 'package:task_manager_app/model/categories.dart';
import 'package:task_manager_app/services/categoriessevices.dart';

class CategoriesProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Category> _categories = [];
  bool _isLoading = false;

  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;

  //get all categories from the API
  Future<void> getCategories() async {
    _isLoading = true;
    notifyListeners();
    try {

      final categoryFetch = await _apiService.getCategories();
      _categories.addAll(categoryFetch);
    } catch (e) {
      print("Error fetching categories: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
  //add a category to the API
  Future<void> addCategory(Category category) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _apiService.addCategory(category);
      _categories.add(category);
    } catch (e) {
      print("Error adding category: $e");
    }
    _isLoading = false;
    notifyListeners();
  }
  //update a category in the API  
  Future<void> updateCategory(Category category) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _apiService.updateCategory(category);
      int index = _categories.indexWhere((c) => c.id == category.id);
      if (index != -1) {
        _categories[index] = category;
      }
    } catch (e) {
      print("Error updating category: $e");
    }
    _isLoading = false;
    notifyListeners();
  }
  //delete a category from the API  
  Future<void> deleteCategory(String id) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _apiService.deleteCategory(id);
      _categories.removeWhere((category) => category.id == id);
    } catch (e) {
      print("Error deleting category: $e");
    }
    _isLoading = false;
    notifyListeners();
  }
  //get a category by id
  Category getCategoryById(String id) {
    return _categories.firstWhere((category) => category.id == id);
  }
}