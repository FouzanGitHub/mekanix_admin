
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../helpers/storage_helper.dart';
import '../../models/category_data_model.dart';
import '../../models/category_model.dart';
import '../api_endpoints.dart';


class CategoriesRepository {

  Future<CategoriesResponse> fetchAllCategories() async {
    try {
      final response = await http.get(
        Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.getAllCategories),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${storage.read('token')}',
        },
      );
      
      // Log the status code and response body
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        return CategoriesResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception("Failed to load categories. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }





  Future<EnginesResponse> fetchCategoryData(String category, String search) async {
    final response = await http.post(
      Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.getCategoriesData),
      headers: {
        'Content-Type': 'application/json',
                'Authorization': 'Bearer ${storage.read('token')}',
      },
      body: json.encode({
        'category': category,
        'search': search,
      }),
    );
  print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
    if (response.statusCode == 200) {

      return EnginesResponse.fromJson(json.decode(response.body));
    } else {
     
      throw Exception('Failed to load engines');
    }
  }


  Future<Map<String, dynamic>> addCategory(String category) async {
    final response = await http.post(
      Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.addCategory),
      headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${storage.read('token')}',
      },
      body: json.encode({
        'name': category,
       
      }),
    );
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
    if (response.statusCode == 201) {
         final data = jsonDecode(response.body);
      return data;
    } else {
     
      throw Exception('Failed to create');
    }
  }
  Future<Map<String, dynamic>> deleteCategory(String id,) async {
    final response = await http.delete(
      Uri.parse('${ApiEndPoints.baseUrl}${ApiEndPoints.deleteCategory}$id'),
      headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${storage.read('token')}',
      },
    
    );
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
    if (response.statusCode == 200) {
         final data = jsonDecode(response.body);
      return data;
    } else {
     
      throw Exception('Failed to create');
    }
  }
  Future<Map<String, dynamic>> updateCategory(String id, String name) async {
    final response = await http.put(
      Uri.parse('${ApiEndPoints.baseUrl}${ApiEndPoints.updateCategory}$id'),
      headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${storage.read('token')}',
      },
      body: json.encode({
        'name': name,
       
      }),
    );
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
    if (response.statusCode == 200) {
         final data = jsonDecode(response.body);
      return data;
    } else {
     
      throw Exception('Failed to create');
    }
  }  
}