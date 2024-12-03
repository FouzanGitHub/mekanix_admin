import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/services/category_service.dart';
import '../helpers/toast.dart';
import '../models/category_data_model.dart';
import '../models/category_model.dart';



class CategoriesController extends GetxController {
  var categoriesResponse = Rx<CategoriesResponse?>(null);
  final CategoriesRepository _createCategory = CategoriesRepository();  
  var isLoading = false.obs;
  var isLoadingCategory = false.obs;
  var errorMessage = ''.obs;
 var categories = <Category>[].obs;
  final CategoriesRepository repository;
  var selectedCategory = ''.obs;
 final searchController = TextEditingController();
   TextEditingController categoryNameController = TextEditingController();
  CategoriesController({required this.repository});

  // Fetch categories from API
  Future<void> fetchCategories() async {
    isLoadingCategory.value = true;
    errorMessage.value = '';

    try {
      categoriesResponse.value = await repository.fetchAllCategories();
       print('Fetched Categories: ${categoriesResponse.value?.data}');
    } catch (e) {
      errorMessage.value = 'Failed to load: $e';
    } finally {
      isLoadingCategory.value = false;
    }
  }

  
  // Variables to store selected category data
  var selectedCategoryName = ''.obs;
  var selectedCategoryId = ''.obs;
  var selectedCategoryDataId = ''.obs;
  var selectedCategoryDataName = ''.obs;
void onInit(){
  super.onInit();
  fetchCategories();
    selectedCategory.value = 'Engine';
    fetchEngines(selectedCategory.value, '');
  // print('assadadasddasd${categoriesResponse.value}');
}




  var enginesResponse = Rx<EnginesResponse?>(null);

  var searchTerm = ''.obs;


  // Fetch engines based on category and search term
  Future<void> fetchEngines(String category, String search) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      enginesResponse.value = await repository.fetchCategoryData(category, search);
      print('Engines fetched: ${enginesResponse.value?.engines?.length}');
      print('Engines fetched: ${enginesResponse.value?.engines[0].categoryId}');
    } catch (e) {
      errorMessage.value = 'Failed to load: $e';
      print('Engines fetched: $e');
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> onCreate() async {


    if (categoryNameController.text.isNotEmpty) {
      isLoading.value = true;

      try {
        final response = await _createCategory.addCategory(categoryNameController.text.trim());
        
           ToastMessage.showToastMessage(
          message: 'Added SuccessFully',
          backgroundColor: Colors.green,
        );
        fetchCategories();
        categoryNameController.clear();
      
      
      
       
        
      } catch (e) {
          ToastMessage.showToastMessage(
          message: 'Failed to create',
          backgroundColor: Colors.red,
       
        );
          print('asdsaasdadas${e}');
      } finally {
        isLoading.value = false; 
      }
    } else {
        ToastMessage.showToastMessage(
          message: 'Failed to create, Please Enter Name',
          backgroundColor: Colors.red,
        );
      
    }
  }
  var  onDeleteLoading = false.obs;
 Future<void> onCategoryDelete(String id) async {



      onDeleteLoading.value = true;

      try {
        final response = await _createCategory.deleteCategory(id);
        
           ToastMessage.showToastMessage(
          message: 'Deleted SuccessFully',
          backgroundColor: Colors.green,
        );
        fetchCategories();
        categoryNameController.clear();
      
      
      
       
        
      } catch (e) {
          ToastMessage.showToastMessage(
          message: 'Failed to delete',
          backgroundColor: Colors.red,
       
        );
 
      } finally {
        onDeleteLoading.value = false; 
      }
    
  }
  var  onUpdateLoading = false.obs;
 Future<void> onCategoryUpdate(String id) async {
   if (categoryNameController.text.isNotEmpty) {
      onUpdateLoading.value = true;

      try {
        final response = await _createCategory.updateCategory(id, categoryNameController.text.trim());
        
           ToastMessage.showToastMessage(
          message: 'Update SuccessFully',
          backgroundColor: Colors.green,
        );
        fetchCategories();
        categoryNameController.clear();
       } catch (e) {
          ToastMessage.showToastMessage(
          message: 'Failed to update',
          backgroundColor: Colors.red,
       
        );
    
      } finally {
        onUpdateLoading.value = false; 
      }
    } else {
        ToastMessage.showToastMessage(
          message: 'Failed to update, Please Enter Name',
          backgroundColor: Colors.red,
        );
    }
 }
  @override
  void onClose() {

    categoryNameController.clear();
   
    super.onClose();
  }
  
}
