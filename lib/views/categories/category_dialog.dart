
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/category_controller.dart';
import '../../controllers/engines_controller.dart';
import '../../data/services/category_service.dart';
import '../../helpers/custom_text.dart';
import '../../helpers/dropdown.dart';



class CategoryDialog extends StatelessWidget {
  final CategoriesController controller = Get.put(CategoriesController(repository: CategoriesRepository()));
 final EnginesController engineController = Get.put(EnginesController());
  @override
  Widget build(BuildContext context) {
    return   Obx(() {
        if (controller.categoriesResponse.value == null) {
          return const Center(child: CircularProgressIndicator(color: Colors.orange,));
        }

        final categories = controller.categoriesResponse.value?.data ?? [];
        
        return CustomDropdown2(
          hintText: 'Select Type', 
          value: controller.selectedCategoryName.value.isEmpty ? null : controller.selectedCategoryName.value,
          items: categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category.name,
                    child: CustomTextWidget(text: '${category.name}')
                  );
                }).toList(),
          onChanged: (newValue) {
                  // Find the category based on the selected name
                  final selectedCategory = categories.firstWhere((category) => category.name == newValue);
                  
                  // Save the selected name and id to different variables
                  controller.selectedCategoryName.value = selectedCategory.name ?? '';
                  controller.selectedCategoryId.value = selectedCategory.id ?? '';
                  
                    engineController.categoryName.value =  controller.selectedCategoryName.value;
                   engineController.categoryId.value =  controller.selectedCategoryId.value;
                
                }, 
          
          );
              // DropdownButton<String>(
              //   hint: const CustomTextWidget(text: 'Select Type',
                
              //   ),
              //   underline: const SizedBox.shrink(),
              //   value: controller.selectedCategoryName.value.isEmpty ? null : controller.selectedCategoryName.value,
              //   isExpanded: true,
              //   items: categories.map((category) {
              //     return DropdownMenuItem<String>(
              //       value: category.name,
              //       child: CustomTextWidget(text: '${category.name}')
              //     );
              //   }).toList(),
              //   onChanged: (newValue) {
              //     // Find the category based on the selected name
              //     final selectedCategory = categories.firstWhere((category) => category.name == newValue);
                  
              //     // Save the selected name and id to different variables
              //     controller.selectedCategoryName.value = selectedCategory.name ?? '';
              //     controller.selectedCategoryId.value = selectedCategory.id ?? '';
                  
              //       engineController.categoryName.value =  controller.selectedCategoryName.value;
              //      engineController.categoryId.value =  controller.selectedCategoryId.value;
                
              //   },
              // );
         
            
          
        
      });
    
  }
}




