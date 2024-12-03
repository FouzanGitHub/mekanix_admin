import 'dart:io';


import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../controllers/category_controller.dart';
import '../../controllers/engines_controller.dart';

import '../../data/services/category_service.dart';
import '../../helpers/appcolors.dart';
import '../../helpers/custom_button.dart';
import '../../helpers/custom_text.dart';
import '../../helpers/responsive_widget.dart';
import '../../helpers/reusable_container.dart';

import '../../helpers/validator.dart';
import '../dashboard/tasks/widgets/heading_and_textfield.dart';
import 'category_dialog.dart';

class CategoryListView extends StatelessWidget {
  final SideMenuController sideMenu;
  CategoryListView({super.key, required this.sideMenu});
  final CategoriesController controller =
      Get.put(CategoriesController(repository: CategoriesRepository()));
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: PopScope(
                canPop: false,
                onPopInvoked: (didPop) {
                  sideMenu.changePage(0);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  const SizedBox(
                    height: 20,
                  ),
                    CustomButton(
                      width: Responsive.isMobile(context) ? context.width * 0.7 : context.width * 0.5,
                      backgroundColor: AppColors.primaryColor,
                      isLoading: false,
                      buttonText: '+ Add Category',
                      fontSize: 14,
                      onTap: () {
                        showCustomPopup(
                          context: context,
                          width: context.width,
                          widget: Column(
                            children: [
                              CustomTextWidget(
                                text: 'Add Category',
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              HeadingAndTextfield(
                                title: 'Enter Name',
                                controller: controller.categoryNameController,
                                hintText: 'Enter Name',
                                validator: (val) =>
                                    AppValidator.validateEmail(value: val),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomButton(
                                buttonText: 'Done',
                                textColor: AppColors.whiteTextColor,
                                onTap: () {
                                  controller.onCreate();

                                  Navigator.pop(context);
                                },
                                isLoading: false,
                                backgroundColor: AppColors.secondaryColor,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(
                      (){
                     final categoryData = controller.categoriesResponse.value?.data ?? [];

                    return   Expanded(
                      child: RefreshIndicator(
                        onRefresh: () => controller.fetchCategories(),
                        color: AppColors.primaryColor,
                        backgroundColor: AppColors.secondaryColor,
                        triggerMode: RefreshIndicatorTriggerMode.onEdge,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: categoryData.length,
                          itemBuilder: (context, index) {
                            var engine = categoryData[index];
                           
                            return Center(
                              child: ReUsableContainer(
                               width: Responsive.isMobile(context) ? context.width * 0.7 : context.width * 0.5,
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  onTap: () {},
                                
                                  title: CustomTextWidget(
                                      text: engine.name ?? 'No Name Specified',
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500),
                                 
                                  trailing:  Wrap(
                                          spacing: 12.0,
                                          children: [
                                            InkWell(
                                            onTap: (){
                                          controller.categoryNameController.text = engine.name ?? '';
                                            // controller.categoryNameController.clear();   
                                              showCustomPopup(
                          context: context,
                          width: context.width,
                          widget: Column(
                            children: [
                              CustomTextWidget(
                                text: 'Edit Category',
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              HeadingAndTextfield(
                                title: 'Enter Name',
                                controller: controller.categoryNameController,
                                hintText: 'Enter Name',
                                validator: (val) =>
                                    AppValidator.validateEmail(value: val),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomButton(
                                buttonText: 'Done',
                                textColor: AppColors.whiteTextColor,
                                onTap: () {
                              
                                  controller.onCategoryUpdate(categoryData[index].id ?? '');
                                
                                  Navigator.pop(context);
                                },
                                isLoading: false,
                                backgroundColor: AppColors.secondaryColor,
                              ),
                            ],
                          ),
                        );
                                            },
                                            child: const Icon(Icons.edit),
                                            ),
                                            // InkWell(
                                            //     onTap: () {
                                            //       _showEditPopup(
                                            //           context: context,
                                            //           controller: controller,
                                            //           controller2: categoryController,
                                            //           model: engine);
                                            //     },
                                            //     child: Icon(Icons.edit,
                                            //         color:
                                            //             AppColors.secondaryColor)),
                                            InkWell(
                                                onTap: () {
                                               
                                                  _showDeletePopup(
                                                      context: context,
                                                      controller: controller,
                                                      onTap:(){
                                                         controller.onCategoryDelete(categoryData[index].id ?? '');
                                                         Get.back();
                                                      });
                                                
                                                },
                                                child: const Icon(Icons.delete,
                                                    color: Colors.red))
                                          ],
                                        ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );    
                      }
                    )
                   
                  ],
                ))));
  }
}

void _openAddEngineDialog({
  required BuildContext context,
  required EnginesController controller,
  required CategoriesController controller2,
}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Dismiss',
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (context, animation, secondaryAnimation) => Container(),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
          scale: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
          child: FadeTransition(
              opacity: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
              child: PopScope(
                  canPop: false,
                  onPopInvoked: (didPop) {
                    if (!didPop) {
                      controller.isQrCodeGenerated.value = false;
                      controller.engineImageUrl.value = '';
                      controller.engineName.clear();
                      controller.engineSubtitle.clear();
                      controller2.selectedCategoryId.value = '';
                      controller2.selectedCategoryName.value = '';
                      Get.back();
                    }
                  },
                  child: AlertDialog(
                      scrollable: true,
                      backgroundColor: Colors.transparent,
                      contentPadding: const EdgeInsets.all(5),
                      content: Container(
                          width: Responsive.isMobile(context)
                              ? context.width * 0.9
                              : context.width * 0.3,
                          height: context.height * 0.7,
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: context.height * 0.02),
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color.fromRGBO(255, 220, 105, 0.4),
                                Color.fromRGBO(86, 127, 255, 0.4),
                              ],
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 5.0,
                                  spreadRadius: 5.0),
                              BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(0.0, 0.0),
                                  blurRadius: 0.0,
                                  spreadRadius: 0.0)
                            ],
                          ),
                          child: PageView(
                              controller: controller.pageController,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                SingleChildScrollView(
                                    child: DialogFirstView(
                                        controller: controller,
                                        controller2: controller2,
                                        categoryName: controller2
                                            .selectedCategory.value)),
                                SingleChildScrollView(
                                    child: DialogSecondView(
                                        controller: controller)),
                              ]))))));
    },
  );
}

class DialogFirstView extends StatelessWidget {
  final EnginesController controller;
  final CategoriesController controller2;
  final dynamic categoryName;
  const DialogFirstView({
    super.key,
    required this.controller,
    required this.controller2,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      InkWell(
        onTap: () => controller.pickImage(),
        child: Obx(
          () => CircleAvatar(
            radius: 45,
            backgroundColor: Colors.white,
            backgroundImage: controller.engineImageUrl.value == ''
                ? const AssetImage('assets/images/placeholder.png')
                    as ImageProvider
                : kIsWeb
                    ? NetworkImage(controller
                        .engineImageUrl.value) // Use NetworkImage on web
                    : FileImage(File(controller.engineImageUrl.value))
                        as ImageProvider,
          ),
        ),
      ),
      const SizedBox(height: 12.0),
      Form(
          key: controller.engineFormKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            HeadingAndTextfield(
                title: 'Enter Engine Name & Model',
                fontSize: 12.0,
                controller: controller.engineName,
                validator: (val) => AppValidator.validateEmptyText(
                    fieldName: 'Engine Name & Model', value: val)),
            HeadingAndTextfield(
                title: 'Enter Subtitle',
                fontSize: 12.0,
                controller: controller.engineSubtitle,
                validator: (val) => AppValidator.validateEmptyText(
                    fieldName: 'Engine Subtitle', value: val)),
            CustomTextWidget(
                text: 'Select Type',
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
                maxLines: 2),
            CategoryDialog(),
          ])),
      Obx(
        () => CustomButton(
            isLoading: controller.isLoading.value,
            backgroundColor: controller.isQrCodeGenerated.value == true
                ? AppColors.primaryColor
                : AppColors.secondaryColor,
            buttonText: 'Save & Generate QR code',
            textColor: AppColors.whiteTextColor,
            fontSize: 12.0,
            onTap: () {
              FormState? formState =
                  controller.engineFormKey.currentState as FormState?;
              if (formState != null && formState.validate()) {
                controller.addEngine();
              }
            }),
      ),
      const Divider(color: Colors.black54),
      Center(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextWidget(
                  text: 'Generate QR Code by filling the above fields.',
                  maxLines: 2,
                  fontSize: 12.0,
                  textAlign: TextAlign.center)))
    ]);
  }
}

class DialogSecondView extends StatelessWidget {
  final EnginesController controller;

  const DialogSecondView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextWidget(
              text: controller.engineName.text,
              maxLines: 2,
              fontSize: 14.0,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black54)),
          child: QrImageView(
            data: controller.engineName.text.trim(),
            version: QrVersions.auto,
            size: 200.0,
          ),
        ),
        const Divider(color: Colors.black54),
        CustomButton(
          isLoading: false,
          buttonText: 'Close',
          fontSize: 12.0,
          onTap: () {
            controller.isQrCodeGenerated.value = false;
            controller.engineImageUrl.value = '';
            controller.engineName.clear();
            controller.engineSubtitle.clear();
            Get.back();
          },
          backgroundColor: controller.isQrCodeGenerated.value == true
              ? AppColors.primaryColor
              : AppColors.secondaryColor,
        ),
      ],
    );
  }
}

void _showEditPopup(
    {required BuildContext context,
    required EnginesController controller,
    required CategoriesController controller2,
    required model}) {
  controller.engineName.text = model.name ?? '';
  controller.engineSubtitle.text = model.subname ?? '';
  controller2.selectedCategoryId.value = model.categoryId ?? '';
  controller2.selectedCategoryName.value = model.categoryName ?? '';
  final CategoriesController categoryController =
      Get.put(CategoriesController(repository: CategoriesRepository()));

  // controller.engineType.value = model.isGenerator! ? 'Generator' : 'Compressor';
  // RxString engineImageUrl = ''.obs;
  controller.updatedEngineImageUrl.value = model.url ?? '';
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Dismiss',
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (context, animation, secondaryAnimation) => Container(),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
          scale: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
          child: FadeTransition(
              opacity: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
              child: PopScope(
                canPop: false,
                onPopInvoked: (didPop) {
                  if (!didPop) {
                    controller.isQrCodeGenerated.value = false;
                    controller.engineImageUrl.value = '';
                    controller.engineName.clear();
                    controller.engineSubtitle.clear();
                    controller.engineType.value = 'Generator';
                    controller2.selectedCategoryId.value = '';
                    controller2.selectedCategoryName.value = '';
                    Get.back();
                  }
                },
                child: AlertDialog(
                    insetPadding: const EdgeInsets.all(20),
                    scrollable: true,
                    backgroundColor: Colors.transparent,
                    content: Container(
                      width: Responsive.isMobile(context)
                          ? context.width * 0.9
                          : context.width * 0.3,
                      height: context.height * 0.7,
                      padding: EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: context.height * 0.02),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color.fromRGBO(255, 220, 105, 0.4),
                            Color.fromRGBO(86, 127, 255, 0.4),
                          ],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 5.0,
                              spreadRadius: 5.0),
                          BoxShadow(
                              color: Colors.white,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 0.0,
                              spreadRadius: 0.0)
                        ],
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              // onTap: () => controller.updateImage(model),
                              onTap: () {
                                controller.updateImage(model);
                              },
                              child: Obx(
                                () => CircleAvatar(
                                  radius: 45,
                                  backgroundColor: Colors.white,
                                  backgroundImage: controller
                                              .updatedEngineImageUrl.value ==
                                          ''
                                      ? const AssetImage(
                                              'assets/images/placeholder.png')
                                          as ImageProvider
                                      : NetworkImage(controller
                                          .updatedEngineImageUrl.value),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12.0),
                            Form(
                              key: controller.engineFormKey,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // CustomTextWidget(
                                    //     text: 'ID: ${model.id}',
                                    //     fontSize: 11.0),
                                    HeadingAndTextfield(
                                        title: 'Enter Engine Name & Model',
                                        fontSize: 12.0,
                                        controller: controller.engineName,
                                        validator: (val) =>
                                            AppValidator.validateEmptyText(
                                                fieldName:
                                                    'Engine Name & Model',
                                                value: val)),
                                    HeadingAndTextfield(
                                        title: 'Enter Subtitle',
                                        fontSize: 12.0,
                                        controller: controller.engineSubtitle,
                                        validator: (val) =>
                                            AppValidator.validateEmptyText(
                                                fieldName: 'Engine Subtitle',
                                                value: val)),
                                    CustomTextWidget(
                                        text: 'Select Engine Type',
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600,
                                        maxLines: 2),
                                    CategoryDialog()
                                  ]),
                            ),
                            Obx(
                              () => CustomButton(
                                  isLoading: controller.isLoading.value,
                                  buttonText: 'Update',
                                  fontSize: 12.0,
                                  textColor: AppColors.whiteTextColor,
                                  onTap: () {
                                    FormState? formState = controller
                                        .engineFormKey
                                        .currentState as FormState?;
                                    if (formState != null &&
                                        formState.validate()) {
                                      controller.updateEngine(
                                          id: model.id ?? '');
                                    }
                                    controller2.fetchEngines(
                                        model.categoryName, '');
                                  },
                                  backgroundColor:
                                      controller.isQrCodeGenerated.value == true
                                          ? AppColors.primaryColor
                                          : AppColors.secondaryColor),
                            ),
                          ]),
                    )),
              )));
    },
  );
}

void _showDeletePopup(
    {required BuildContext context,
    required  controller,
    required onTap}) {
  final CategoriesController categoryController =
      Get.put(CategoriesController(repository: CategoriesRepository()));
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Dismiss',
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (context, animation, secondaryAnimation) => Container(),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
          scale: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
          child: FadeTransition(
              opacity: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
              child: AlertDialog(
                  scrollable: true,
                  backgroundColor: Colors.transparent,
                  content: Container(
                    width: Responsive.isMobile(context)
                        ? context.width * 0.9
                        : context.width * 0.3,
                    // height: context.height * 0.3,
                    padding: EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: context.height * 0.02),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color.fromRGBO(255, 220, 105, 0.4),
                          Color.fromRGBO(86, 127, 255, 0.4),
                        ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5.0,
                            spreadRadius: 5.0),
                        BoxShadow(
                            color: Colors.white,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0)
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomTextWidget(
                            text:
                                'Are you sure to delete? This action cannot be undone.',
                            fontSize: 14.0,
                            maxLines: 3,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w400),
                        const SizedBox(height: 12.0),
                          Obx(()=>
                             CustomButton(
                              
                            isLoading: controller.onDeleteLoading.value,
                            backgroundColor: AppColors.redColor,
                            textColor: AppColors.whiteTextColor,
                            buttonText: 'Delete',
                            fontSize: 12.0,
                            onTap: onTap
                 ),
                          ),
                        // Obx(
                        //   () => InkWell(
                        //       onTap: (){
                        //         Get.back();
                        //       },
                        //       child: 
                        //       ReUsableContainer(
                        //         verticalPadding: context.height * 0.01,
                        //         height: 50,
                        //         color: Colors.red,
                        //         child: Center(
                        //             child: controller.onDeleteLoading.value
                        //                 ? const Padding(
                        //                     padding: EdgeInsets.all(8.0),
                        //                     child: SpinKitRing(
                        //                       lineWidth: 2.0,
                        //                       color: Colors.white,
                        //                     ),
                        //                   )
                        //                 : CustomTextWidget(
                        //                     text: 'Delete',
                        //                     fontSize: 12,
                        //                     textColor: Colors.white,
                        //                     fontWeight: FontWeight.w600,
                        //                     textAlign: TextAlign.center,
                        //                   )
                        //                   ),
                        //       )),
                        // ),
                        CustomButton(
                          isLoading: false,
                          backgroundColor: AppColors.secondaryColor,
                          textColor: AppColors.whiteTextColor,
                          buttonText: 'Cancel',
                          fontSize: 12.0,
                          onTap: () {
                        
                            Get.back();

                          },
                        )
                      ],
                    ),
                  ))));
    },
  );
}

void showCustomPopup(
    {required BuildContext context,
    required double? width,
    required Widget widget}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Dismiss',
    transitionDuration: const Duration(milliseconds: 100),
    pageBuilder: (context, animation, secondaryAnimation) => Container(),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
          scale: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
          child: FadeTransition(
              opacity: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
              child: AlertDialog(
                  insetPadding: const EdgeInsets.all(20),
                  scrollable: true,
                  backgroundColor: Colors.transparent,
                  content: Container(
                    width: Responsive.isMobile(context)
                        ? context.width * 0.9
                        : context.width * 0.3,
                    padding: EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: context.height * 0.05),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color.fromRGBO(255, 220, 105, 0.4),
                          Color.fromRGBO(86, 127, 255, 0.4),
                        ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5.0,
                            spreadRadius: 5.0),
                        BoxShadow(
                            color: Colors.white,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0)
                      ],
                    ),
                    child: widget,
                  ))));
    },
  );
}
