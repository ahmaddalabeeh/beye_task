import 'package:beye_group/helpers/helpers.dart';
import 'package:beye_group/pages/table_screen/controller/loan_controller.dart';
import 'package:beye_group/singletons/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class QuickFactExpansionTile extends StatelessWidget {
  final LoanController loanController;
  final int quickFactIndex;
  final int initialVisibilityCardIndex;
  final int kpiFirstCardIndex;
  final int kpiSecondCardIndex;
  const QuickFactExpansionTile(
      {super.key,
      required this.loanController,
      required this.quickFactIndex,
      required this.initialVisibilityCardIndex,
      required this.kpiFirstCardIndex,
      required this.kpiSecondCardIndex});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: ExpansionTile(
          dense: true,
          tilePadding: EdgeInsets.symmetric(horizontal: 1.7.w),
          collapsedIconColor: AppColors.lightGrey,
          shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 1,
                color: AppColors.borderColor,
              ),
              borderRadius: BorderRadius.circular(8.r)),
          collapsedShape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 1,
                color: AppColors.borderColor,
              ),
              borderRadius: BorderRadius.circular(8.r)),
          collapsedTextColor: AppColors.primaryText,
          backgroundColor: AppColors.white,
          collapsedBackgroundColor: Colors.white,
          title: Text(
              'Quick Facts ${loanController.quickFactLabels[quickFactIndex]} ${loanController.quickFactValues[quickFactIndex]}'),
          children: <Widget>[
            ListTile(
              title: const Text('KpiAlias'),
              onTap: () {
                if (loanController
                        .initialVisibleKpiCards[initialVisibilityCardIndex] &&
                    !loanController
                        .initialInvisibleKpiCards[initialVisibilityCardIndex]) {
                  loanController.quickFactLabels[quickFactIndex] =
                      '- KpiAlias - ';
                  loanController.quickFactValues[quickFactIndex] =
                      loanController.kpiData[kpiFirstCardIndex]['kpiAlias'];
                } else {
                  loanController.quickFactLabels[quickFactIndex] =
                      '- KpiAlias - ';
                  loanController.quickFactValues[quickFactIndex] =
                      loanController.kpiData[kpiSecondCardIndex]['kpiAlias'];
                }
              },
            ),
            ListTile(
              title: const Text('Current'),
              onTap: () {
                if (loanController
                        .initialVisibleKpiCards[initialVisibilityCardIndex] &&
                    !loanController
                        .initialInvisibleKpiCards[initialVisibilityCardIndex]) {
                  loanController.quickFactLabels[quickFactIndex] =
                      '- Current - ';
                  loanController.quickFactValues[quickFactIndex] = Helpers()
                      .formatNumber(
                          loanController.kpiData[kpiFirstCardIndex]['current']);
                } else {
                  loanController.quickFactLabels[quickFactIndex] =
                      '- Current - ';
                  loanController.quickFactValues[quickFactIndex] = Helpers()
                      .formatNumber(loanController.kpiData[kpiSecondCardIndex]
                          ['current']);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
