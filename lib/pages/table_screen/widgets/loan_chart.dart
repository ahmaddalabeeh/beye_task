import 'package:beye_group/pages/table_screen/controller/loan_controller.dart';
import 'package:beye_group/shared/widgets/main_text.dart';
import 'package:beye_group/singletons/app_colors.dart';
import 'package:beye_group/singletons/app_icons.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LoanChart extends StatelessWidget {
  final Color color;
  final bool visibility;
  final LoanController loanController;
  final String currentText;
  final String kpiAliasText;
  const LoanChart(
      {super.key,
      required this.color,
      required this.currentText,
      required this.kpiAliasText,
      required this.visibility,
      required this.loanController});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visibility,
      child: Container(
        height: 260.h,
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0XFFEFEFEF)),
            borderRadius: BorderRadius.circular(8.r)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              MainText(
                                text: currentText,
                                fontSize: 30.spMin,
                                color: AppColors.primaryText,
                                fontWeight: FontWeight.w700,
                              ),
                            ],
                          ),
                          MainText(
                            text: kpiAliasText,
                            fontSize: 14.spMin,
                            fontWeight: FontWeight.w400,
                            color: color,
                          ),
                        ],
                      ),
                      SvgPicture.asset(AppIcons.options)
                    ],
                  ),
                  SizedBox(height: 50.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 100.h,
                          width: 70.w,
                          child: LineChart(
                            LineChartData(
                              lineBarsData: [
                                LineChartBarData(
                                  spots: [
                                    const FlSpot(0, 1),
                                    const FlSpot(1, 1.5),
                                    const FlSpot(2, 1.4),
                                    const FlSpot(3, 2.5),
                                    const FlSpot(4, 2),
                                    const FlSpot(5, 2.2),
                                    const FlSpot(6, 1.8),
                                    const FlSpot(7, 1),
                                  ],
                                  isCurved: true,
                                  dotData: const FlDotData(show: false),
                                  color: color,
                                  belowBarData: BarAreaData(
                                    show: true,
                                    gradient: LinearGradient(
                                        colors: [
                                          color,
                                          const Color(0xFFFFFFFF),
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter),
                                  ),
                                ),
                              ],
                              gridData: const FlGridData(show: false),
                              titlesData: const FlTitlesData(show: false),
                              borderData: FlBorderData(
                                show: false,
                                border: Border.all(color: AppColors.black),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MainText(
                            text: 'YOY - Growth',
                            color: const Color(0XFF888888),
                            fontSize: 12.spMin,
                          ),
                          Row(
                            children: [
                              MainText(
                                text: '16,598.63K',
                                color: const Color(0XFF525252),
                                fontSize: 12.spMin,
                              ),
                              SizedBox(width: 4.w),
                              SvgPicture.asset(AppIcons.growth)
                            ],
                          ),
                          MainText(
                            text: 'YTD - Budget',
                            color: const Color(0XFF888888),
                            fontSize: 12.spMin,
                          ),
                          Row(
                            children: [
                              MainText(
                                text: '16,598.63K',
                                color: const Color(0XFF525252),
                                fontSize: 12.spMin,
                              ),
                              SizedBox(width: 4.w),
                              SvgPicture.asset(AppIcons.budget)
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: Get.width,
              height: 10.h,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8.r),
                  bottomRight: Radius.circular(8.r),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
