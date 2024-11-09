import 'package:beye_group/helpers/helpers.dart';
import 'package:beye_group/pages/table_screen/controller/loan_controller.dart';
import 'package:beye_group/pages/table_screen/source/loan_data_source.dart';
import 'package:beye_group/pages/table_screen/widgets/kpi_column.dart';
import 'package:beye_group/singletons/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class LoanDataGridScreen extends StatelessWidget {
  final LoanController loanController = Get.put(LoanController());

  LoanDataGridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    loanController.loadJsonDataAsync();
    loanController.loadKpiCardDataAsync();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Obx(() {
          if (loanController.columns.isEmpty || loanController.rows.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KpiColumn(
                    initialInvisibleKpi:
                        loanController.initialInvisibleKpiCards[0],
                    initialVisibleKpi: loanController.initialVisibleKpiCards[0],
                    kpiFirstAlias: loanController.kpiData[0]['kpiAlias'],
                    kpiSecondAlias: loanController.kpiData[1]['kpiAlias'],
                    currentFirstText: Helpers()
                        .formatNumber(loanController.kpiData[0]['current']),
                    currentSecondText: Helpers()
                        .formatNumber(loanController.kpiData[1]['current']),
                    colorFirst: AppColors.primaryDarkBlue,
                    colorSecond: AppColors.red,
                    onFirstTabTap: () => loanController.toggleHiddenCharts(0),
                    onSecondTabTap: () => loanController.toggleVisibleCharts(0),
                    loanController: loanController,
                    quickFactIndex: 0,
                    initialVisibilityCardIndex: 0,
                    kpiFirstCardIndex: 0,
                    kpiSecondCardIndex: 1,
                  ),
                  KpiColumn(
                    initialInvisibleKpi:
                        loanController.initialInvisibleKpiCards[1],
                    initialVisibleKpi: loanController.initialVisibleKpiCards[1],
                    kpiFirstAlias: loanController.kpiData[2]['kpiAlias'],
                    kpiSecondAlias: loanController.kpiData[3]['kpiAlias'],
                    currentFirstText: Helpers()
                        .formatNumber(loanController.kpiData[2]['current']),
                    currentSecondText: Helpers()
                        .formatNumber(loanController.kpiData[3]['current']),
                    colorFirst: AppColors.green,
                    colorSecond: AppColors.blue,
                    onFirstTabTap: () => loanController.toggleHiddenCharts(1),
                    onSecondTabTap: () => loanController.toggleVisibleCharts(1),
                    loanController: loanController,
                    quickFactIndex: 1,
                    initialVisibilityCardIndex: 1,
                    kpiFirstCardIndex: 2,
                    kpiSecondCardIndex: 3,
                  ),
                  KpiColumn(
                    initialInvisibleKpi:
                        loanController.initialInvisibleKpiCards[2],
                    initialVisibleKpi: loanController.initialVisibleKpiCards[2],
                    kpiFirstAlias: loanController.kpiData[4]['kpiAlias'],
                    kpiSecondAlias: loanController.kpiData[5]['kpiAlias'],
                    currentFirstText: Helpers()
                        .formatNumber(loanController.kpiData[4]['current']),
                    currentSecondText: Helpers()
                        .formatNumber(loanController.kpiData[5]['current']),
                    colorFirst: AppColors.black,
                    colorSecond: AppColors.grey,
                    onFirstTabTap: () => loanController.toggleHiddenCharts(2),
                    onSecondTabTap: () => loanController.toggleVisibleCharts(2),
                    loanController: loanController,
                    quickFactIndex: 2,
                    initialVisibilityCardIndex: 2,
                    kpiFirstCardIndex: 4,
                    kpiSecondCardIndex: 5,
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                child: SfDataGrid(
                  allowFiltering: true,
                  source: LoanDataSource(
                      loanController.rows, loanController.columns),
                  columns: [
                    GridColumn(
                      allowFiltering: false,
                      minimumWidth: 10.w,
                      maximumWidth: 50.w,
                      columnName: 'index',
                      label: Container(
                        padding: EdgeInsets.all(8.r),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.primaryDarkBlue,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.r),
                            topRight: Radius.zero,
                          ),
                          border:
                              Border.all(color: AppColors.white, width: 0.5.w),
                        ),
                        child: const Text(
                          '#',
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    ...loanController.columns.map((column) {
                      return GridColumn(
                        columnName: column['name'],
                        label: GestureDetector(
                          onTap: () {
                            loanController.sortColumn(column['name']);
                          },
                          child: Container(
                            padding: EdgeInsets.all(8.r),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.primaryDarkBlue,
                              border: Border.all(
                                  color: AppColors.white, width: 0.5.w),
                            ),
                            child: Text(
                              column['title'],
                              style: const TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                  gridLinesVisibility: GridLinesVisibility.both,
                  headerGridLinesVisibility: GridLinesVisibility.both,
                  columnWidthMode: ColumnWidthMode.fill,
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
