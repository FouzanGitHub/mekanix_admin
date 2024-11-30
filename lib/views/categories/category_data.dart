
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/category_controller.dart';

import '../../controllers/custom_template_controller.dart';
import '../../controllers/engines_controller.dart';
import '../../data/services/category_service.dart';
import '../../helpers/custom_text.dart';
import '../../helpers/dropdown.dart';


class CategoryDataDialog extends StatelessWidget {
  final CategoriesController controller = Get.put(CategoriesController(repository: CategoriesRepository()));
 final EnginesController engineController = Get.put(EnginesController());
 final CustomTaskController taskController = Get.put(CustomTaskController());
  @override
  Widget build(BuildContext context) {
    return   Obx(() {
         controller.fetchEngines('', '');
        if (controller.enginesResponse.value == null) {
          return const Center(child: CircularProgressIndicator(color: Colors.orange,));
        }
        
        final categories = controller.enginesResponse.value?.engines ?? [];
     
        return CustomDropdown2(
          hintText: 'Select ', 
          value: controller.selectedCategoryDataName.value.isEmpty ? null : controller.selectedCategoryDataName.value,
          items: categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category.name,
                    child: CustomTextWidget(text: '${category.name}')
                  );
                }).toList(),
          onChanged: (newValue) {
            
                  // Find the category based on the selected name
                  final selectedCategoryData = categories.firstWhere((category) => category.name == newValue);
                  
                  // Save the selected name and id to different variables
                  controller.selectedCategoryDataName.value = selectedCategoryData.name ?? '';
                  controller.selectedCategoryDataId.value = selectedCategoryData.id ?? '';
                  
                    taskController.engineBrandName.value =  controller.selectedCategoryDataName.value;
                   taskController.engineBrandId.value =  controller.selectedCategoryDataId.value;
                  print('sadad${  taskController.engineBrandId.value}');
                }, 
          
          );
         
         
            
          
        
      });
    
  }
}




