import 'package:beye_group/pages/table_screen/controller/loan_controller.dart';
import 'package:beye_group/shared/widgets/main_text.dart';
import 'package:beye_group/singletons/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LoanChart extends StatelessWidget {
  final Color color;
  final bool visibility;
  final String currentText;
  final String kpiAliasText;
  final LoanController loanController;
  final int kpiCardIndex;

  const LoanChart({
    super.key,
    required this.color,
    required this.currentText,
    required this.kpiAliasText,
    required this.visibility,
    required this.kpiCardIndex,
    required this.loanController,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visibility,
      child: Container(
        height: 260.h,
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.white),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MainText(
                    text: currentText,
                    fontSize: 24.spMin,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                  MainText(
                    text: kpiAliasText,
                    fontSize: 14.spMin,
                    color: color,
                  ),
                ],
              ),
            ),
            Expanded(
              child: SfCartesianChart(
                margin: EdgeInsets.zero,
                plotAreaBorderWidth: 0,
                primaryXAxis: const NumericAxis(
                  isVisible: false,
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                ),
                primaryYAxis: const NumericAxis(
                  isVisible: false,
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                ),
                series: [
                  SplineAreaSeries<ChartData, double>(
                    dataSource: loanController.kpiData.isNotEmpty
                        ? loanController.kpiData[kpiCardIndex]['data']
                        : [],
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    gradient: LinearGradient(
                      colors: [color, AppColors.white],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderColor: color,
                    borderWidth: 0.5.w,
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 10.h,
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ChartData {
  final double x;
  final double y;

  ChartData(this.x, this.y);
}
