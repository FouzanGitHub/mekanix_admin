import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mechanix_admin/controllers/universal_controller.dart';
import 'package:mechanix_admin/helpers/appcolors.dart';
import 'package:mechanix_admin/helpers/custom_text.dart';
import 'package:mechanix_admin/helpers/reusable_container.dart';
import 'package:mechanix_admin/models/analytics_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../controllers/category_controller.dart';
import '../../data/services/category_service.dart';

class HomeSection extends StatefulWidget {
  final SideMenuController sideMenu;

  const HomeSection({
    super.key,
    required this.sideMenu,
  });

  @override
  State<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection> {
  final UniversalController controller = Get.find();
  List<_ChartData> chartData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    controller.getActivitiesAnalyticsData().then((_) {
      setState(() {
        chartData = _prepareChartData(controller.analyticsData);
        isLoading = false;
      });
    });
  }

  List<_ChartData> _prepareChartData(AnalyticsData analyticsData) {
    final List<String> allMonths = [
      "Jan",
      "Feb",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "Sept",
      "Oct",
      "Nov",
      "Dec"
    ];

    final Map<String, _ChartData> dataMap = {
      for (var month in allMonths) month: _ChartData(month, 0, 0, 0, 0, 0)
    };

    for (var activity in analyticsData.loginActivity!) {
      dataMap[activity.month!] = dataMap[activity.month!]?.copyWith(
            loginActivity: activity.loginCount!,
          ) ??
          _ChartData(activity.month!, activity.loginCount!, 0, 0, 0, 0);
    }

    for (var activity in analyticsData.accountCreationActivity!) {
      dataMap[activity.month!] = dataMap[activity.month!]?.copyWith(
            accountCreationActivity: activity.accountCreationCount!,
          ) ??
          _ChartData(
              activity.month!, 0, activity.accountCreationCount!, 0, 0, 0);
    }

    for (var activity in analyticsData.engineActivity!) {
      dataMap[activity.month!] = dataMap[activity.month!]?.copyWith(
            engineTask: activity.engineCreationCount!,
          ) ??
          _ChartData(
              activity.month!, 0, 0, activity.engineCreationCount!, 0, 0);
    }

    for (var activity in analyticsData.formBuilderActivity!) {
      dataMap[activity.month!] = dataMap[activity.month!]?.copyWith(
            formBuilderActivity: activity.formBuilderActivity!,
          ) ??
          _ChartData(
              activity.month!, 0, 0, 0, activity.formBuilderActivity!, 0);
    }

    for (var activity in analyticsData.templateActivity!) {
      dataMap[activity.month!] = dataMap[activity.month!]?.copyWith(
            templateActivity: activity.formBuilderActivity!,
          ) ??
          _ChartData(
              activity.month!, 0, 0, 0, 0, activity.formBuilderActivity!);
    }

    return dataMap.values.toList();
  }

  @override
  Widget build(BuildContext context) {
  final UniversalController universalController = Get.put(UniversalController());
  final CategoriesController categoryController = Get.put(CategoriesController(repository: CategoriesRepository()));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 16.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        color: Colors.transparent,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () { 
               
                return Wrap(
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  runAlignment: WrapAlignment.center,
                  children: [
                    buildContainer(
                      text: 'Total Users',
                      icon: FontAwesomeIcons.userLarge,
                      value: controller.totalUsersCount,
                      isLoading: controller.isLoadingTotalUsers.value,
                      onTap: () => widget.sideMenu.changePage(3),
                    ),
                    buildContainer(
                      text: 'Verified Users',
                      icon: FontAwesomeIcons.userCheck,
                      value: controller.totalVerifiedUsersCount,
                      isLoading: controller.isLoadingVerifiedUsers.value,
                      onTap: () => widget.sideMenu.changePage(3),
                    ),
                    buildContainer(
                      text: 'Unverified Users',
                      icon: FontAwesomeIcons.userTimes,
                      value: controller.totalUnverifiedUsersCount,
                      isLoading: controller.isLoadingUnverifiedUsers.value,
                    ),
                    buildContainer(
                      text: 'Approved Account',
                      icon: FontAwesomeIcons.userCheck,
                      value: controller.approvedAccountCount,
                      isLoading: controller.isLoadingApprovedAccount.value,
                      onTap: () => widget.sideMenu.changePage(3),
                    ),
                    buildContainer(
                      text: 'Unapproved Account',
                      icon: FontAwesomeIcons.userTimes,
                      value: controller.unapprovedAccountCount,
                      isLoading: controller.isLoadingUnapprovedAccount.value,
                    ),
                    buildContainer(
                      text: 'Total Generator\'s Created',
                      icon: FontAwesomeIcons.fileInvoice,
                      value: controller.generatorCount,
                      isLoading: controller.isLoadingGeneratorCount.value,
                    ),
                    buildContainer(
                      text: 'Total Compressor\'s Created',
                      icon: FontAwesomeIcons.fileInvoice,
                      value: controller.compressorCount,
                      isLoading: controller.isLoadingCompressorCount.value,
                    ),
                    buildContainer(
                      text: 'Assembly Forms Created',
                      icon: FontAwesomeIcons.fileInvoice,
                      value: controller.formsCount,
                      isLoading: controller.isLoadingFormsCount.value,
                    ),
                    buildContainer(
                      text: 'Total Templates Created',
                      icon: FontAwesomeIcons.fileInvoice,
                     value: controller.templatesCount,
                      isLoading: controller.isLoadingTemplatesCount.value,
                  
                    ),
                     buildContainer(
                      text: 'Total Categories Created',
                      icon:Icons.category_outlined,
                     value: controller.categoryCount,
                      isLoading: controller.isLoadingTemplatesCount.value,
                                       
                                         ),
                    // buildContainer(
                    //   text: 'Total Equipments',
                    //   icon: FontAwesomeIcons.list,
                    //  value: controller.equipmentCount,
                    //   isLoading: controller.isLoadingTemplatesCount.value,
                                       
                    //                      ),                     
                    
                
                  ],
                );},
              ),
              _buildGraph(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGraph(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ReUsableContainer(
        color: Colors.grey.shade100,
        height: MediaQuery.of(context).size.height * 0.5,
        child: isLoading
            ? Center(
                child: SpinKitThreeBounce(
                  color: AppColors.secondaryColor,
                  size: 25.0,
                ),
              )
            : SfCartesianChart(
                plotAreaBorderWidth: 1,
                enableAxisAnimation: true,
                enableMultiSelection: true,
                enableSideBySideSeriesPlacement: true,
                title: const ChartTitle(
                    text: 'Annual User Engagement Insights',
                    textStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w600)),
                legend: const Legend(isVisible: true),
                primaryXAxis: const CategoryAxis(
                  majorGridLines: MajorGridLines(width: 1),
                  labelRotation: 0,
                ),
                primaryYAxis: NumericAxis(
                  rangePadding: ChartRangePadding.none,
                  axisLine: const AxisLine(width: 0),
                  majorTickLines: const MajorTickLines(size: 6),
                  minimum: 0,
                  maximum: _getMaximumYValue(chartData),
                ),
                series: _getLineSeries(),
                tooltipBehavior: TooltipBehavior(enable: true),
              ),
      ),
    );
  }

  // Padding _buildGraph(BuildContext context) {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(
  //         horizontal: MediaQuery.of(context).size.width * 0.05),
  //     child: ReUsableContainer(
  //       color: Colors.grey.shade100,
  //       height: MediaQuery.of(context).size.height * 0.5,
  //       child: isLoading
  //           ? Center(
  //               child: SpinKitThreeBounce(
  //                 color: AppColors.secondaryColor,
  //                 size: 25.0,
  //               ),
  //             )
  //           : SfCartesianChart(
  //               plotAreaBorderWidth: 1,
  //               isTransposed: false,
  //               enableAxisAnimation: true,
  //               enableMultiSelection: true,
  //               enableSideBySideSeriesPlacement: false,
  //               title: const ChartTitle(
  //                   text: 'Yearly Analytics Data',
  //                   textStyle: TextStyle(fontSize: 14, fontFamily: 'Poppins')),
  //               legend: const Legend(isVisible: true),
  //               primaryXAxis: const CategoryAxis(
  //                 majorGridLines: MajorGridLines(width: 1),
  //                 labelRotation: 0,
  //               ),
  //               primaryYAxis: const NumericAxis(
  //                 rangePadding: ChartRangePadding.none,
  //                 axisLine: AxisLine(width: 0),
  //                 majorTickLines: MajorTickLines(size: 6),
  //               ),
  //               series: _getLineSeries(),
  //               tooltipBehavior: TooltipBehavior(enable: true),
  //             ),
  //     ),
  //   );
  // }

  List<CartesianSeries<_ChartData, String>> _getLineSeries() {
    return <CartesianSeries<_ChartData, String>>[
      LineSeries<_ChartData, String>(
        dataSource: chartData,
        xValueMapper: (_ChartData data, _) => data.month,
        yValueMapper: (_ChartData data, _) => data.loginActivity,
        name: 'Login Activity',
        markerSettings: const MarkerSettings(isVisible: true),
      ),
      LineSeries<_ChartData, String>(
        dataSource: chartData,
        xValueMapper: (_ChartData data, _) => data.month,
        yValueMapper: (_ChartData data, _) => data.accountCreationActivity,
        name: 'Account Creation',
        markerSettings: const MarkerSettings(isVisible: true),
      ),
      LineSeries<_ChartData, String>(
        dataSource: chartData,
        xValueMapper: (_ChartData data, _) => data.month,
        yValueMapper: (_ChartData data, _) => data.engineTask,
        name: 'Engine Task',
        markerSettings: const MarkerSettings(isVisible: true),
      ),
      LineSeries<_ChartData, String>(
        dataSource: chartData,
        xValueMapper: (_ChartData data, _) => data.month,
        yValueMapper: (_ChartData data, _) => data.formBuilderActivity,
        name: 'Form Activity',
        markerSettings: const MarkerSettings(isVisible: true),
      ),
      LineSeries<_ChartData, String>(
        dataSource: chartData,
        xValueMapper: (_ChartData data, _) => data.month,
        yValueMapper: (_ChartData data, _) => data.templateActivity,
        name: 'Template Activity',
        markerSettings: const MarkerSettings(isVisible: true),
      ),
    ];
  }

  double _getMaximumYValue(List<_ChartData> chartData) {
    num maxValue = 0;
    for (var data in chartData) {
      maxValue = [
        maxValue,
        data.loginActivity,
        data.accountCreationActivity,
        data.engineTask,
        data.formBuilderActivity,
        data.templateActivity
      ].reduce((value, element) => value > element ? value : element);
    }
    return maxValue + 5; // Adding some padding to the maximum value
  }

  // List<CartesianSeries<_ChartData, String>> _getStackedLineSeries() {
  //   return <CartesianSeries<_ChartData, String>>[
  //     StackedLineSeries<_ChartData, String>(
  //       dataSource: chartData,
  //       xValueMapper: (_ChartData data, _) => data.month,
  //       yValueMapper: (_ChartData data, _) => data.loginActivity,
  //       name: 'Login Activity',
  //       markerSettings: const MarkerSettings(isVisible: true),
  //     ),
  //     StackedLineSeries<_ChartData, String>(
  //       dataSource: chartData,
  //       xValueMapper: (_ChartData data, _) => data.month,
  //       yValueMapper: (_ChartData data, _) => data.accountCreationActivity,
  //       name: 'Account Creation',
  //       markerSettings: const MarkerSettings(isVisible: true),
  //     ),
  //     StackedLineSeries<_ChartData, String>(
  //       dataSource: chartData,
  //       xValueMapper: (_ChartData data, _) => data.month,
  //       yValueMapper: (_ChartData data, _) => data.engineTask,
  //       name: 'Engine Task',
  //       markerSettings: const MarkerSettings(isVisible: true),
  //     ),
  //     StackedLineSeries<_ChartData, String>(
  //       dataSource: chartData,
  //       xValueMapper: (_ChartData data, _) => data.month,
  //       yValueMapper: (_ChartData data, _) => data.formBuilderActivity,
  //       name: 'Form Activity',
  //       markerSettings: const MarkerSettings(isVisible: true),
  //     ),
  //     StackedLineSeries<_ChartData, String>(
  //       dataSource: chartData,
  //       xValueMapper: (_ChartData data, _) => data.month,
  //       yValueMapper: (_ChartData data, _) => data.templateActivity,
  //       name: 'Template Activity',
  //       markerSettings: const MarkerSettings(isVisible: true),
  //     ),
  //   ];
  // }

  Widget buildContainer({
    required String text,
    required RxInt value,
    required bool isLoading,
    required IconData icon,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ReUsableContainer(
        color: Colors.grey.shade100,
        borderRadius: 18.0,
        onTap: onTap,
        width: 180,
        height: 120,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(icon),
              CustomTextWidget(
                text: text,
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.center,
                textColor: AppColors.contentColorBlack.withOpacity(0.8),
                maxLines: 2,
              ),
              isLoading
                  ? SpinKitThreeBounce(
                      color: AppColors.secondaryColor,
                      size: 25.0,
                    )
                  : CustomTextWidget(
                      text: '${value.value}',
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.month, this.loginActivity, this.accountCreationActivity,
      this.engineTask, this.formBuilderActivity, this.templateActivity);

  final String month;
  final num loginActivity;
  final num accountCreationActivity;
  final num engineTask;
  final num formBuilderActivity;
  final num templateActivity;

  _ChartData copyWith(
      {num? loginActivity,
      num? accountCreationActivity,
      num? engineTask,
      num? formBuilderActivity,
      num? templateActivity}) {
    return _ChartData(
      month,
      loginActivity ?? this.loginActivity,
      accountCreationActivity ?? this.accountCreationActivity,
      engineTask ?? this.engineTask,
      formBuilderActivity ?? this.formBuilderActivity,
      templateActivity ?? this.templateActivity,
    );
  }
}
