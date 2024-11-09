import 'package:beye_group/pages/table_screen/controller/loan_controller.dart';
import 'package:beye_group/pages/table_screen/widgets/custom_tab.dart';
import 'package:beye_group/pages/table_screen/widgets/loan_chart.dart';
import 'package:beye_group/pages/table_screen/widgets/quick_fact_expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class KpiColumn extends StatelessWidget {
  final bool initialInvisibleKpi;
  final bool initialVisibleKpi;
  final String kpiFirstAlias;
  final String kpiSecondAlias;
  final String currentFirstText;
  final String currentSecondText;
  final Color colorFirst;
  final Color colorSecond;
  final Function onFirstTabTap;
  final Function onSecondTabTap;
  final LoanController loanController;
  final int quickFactIndex;
  final int initialVisibilityCardIndex;
  final int kpiFirstCardIndex;
  final int kpiSecondCardIndex;
  final int columnIndex;

  const KpiColumn({
    super.key,
    required this.initialInvisibleKpi,
    required this.initialVisibleKpi,
    required this.kpiFirstAlias,
    required this.kpiSecondAlias,
    required this.currentFirstText,
    required this.currentSecondText,
    required this.colorFirst,
    required this.colorSecond,
    required this.onFirstTabTap,
    required this.onSecondTabTap,
    required this.loanController,
    required this.quickFactIndex,
    required this.initialVisibilityCardIndex,
    required this.kpiFirstCardIndex,
    required this.kpiSecondCardIndex,
    required this.columnIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: loanController.chartVisibility[columnIndex] ||
                    !initialInvisibleKpi
                ? 1.0
                : 0.0,
            child: Visibility(
              visible: loanController.initialVisibleKpiCards[columnIndex]
                  ? false
                  : initialInvisibleKpi,
              child: AnimatedSize(
                duration: const Duration(milliseconds: 500),
                child: CustomTab(
                  title: kpiFirstAlias,
                  onTap: () => onFirstTabTap(),
                ),
              ),
            ),
          ),
          Obx(() => AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: loanController.chartVisibility[columnIndex] &&
                        initialVisibleKpi
                    ? 1.0
                    : 0.0,
                child: Visibility(
                  visible: loanController.chartVisibility[columnIndex] &&
                      initialVisibleKpi,
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 500),
                    child: LoanChart(
                      currentText: currentFirstText,
                      kpiCardIndex: kpiFirstCardIndex,
                      kpiAliasText: kpiFirstAlias,
                      loanController: loanController,
                      color: colorFirst,
                      visibility: initialVisibleKpi,
                    ),
                  ),
                ),
              )),
          Obx(() => AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: loanController.chartVisibility[columnIndex] &&
                        !initialVisibleKpi
                    ? 1.0
                    : 0.0,
                child: Visibility(
                  visible: loanController.chartVisibility[columnIndex] &&
                      !initialVisibleKpi,
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 500),
                    child: LoanChart(
                      currentText: currentSecondText,
                      kpiCardIndex: kpiSecondCardIndex,
                      kpiAliasText: kpiSecondAlias,
                      loanController: loanController,
                      color: colorSecond,
                      visibility: !initialVisibleKpi,
                    ),
                  ),
                ),
              )),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: !initialInvisibleKpi ? 1.0 : 0.0,
            child: Visibility(
              visible: !initialInvisibleKpi,
              child: CustomTab(
                title: kpiSecondAlias,
                onTap: () => onSecondTabTap(),
              ),
            ),
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 900),
            opacity: 1.0,
            child: QuickFactExpansionTile(
              loanController: loanController,
              quickFactIndex: quickFactIndex,
              initialVisibilityCardIndex: initialVisibilityCardIndex,
              kpiFirstCardIndex: kpiFirstCardIndex,
              kpiSecondCardIndex: kpiSecondCardIndex,
              columnIndex: columnIndex,
            ),
          ),
        ],
      ),
    );
  }
}
