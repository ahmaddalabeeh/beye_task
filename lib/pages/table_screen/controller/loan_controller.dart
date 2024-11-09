import 'dart:convert';

import 'package:beye_group/pages/table_screen/widgets/loan_chart.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LoanController extends GetxController {
  RxList<bool> chartVisibility = [true, true, true].obs;

  var columns = <Map<String, dynamic>>[].obs;
  var rows = <Map<String, dynamic>>[].obs;
  var kpiData = <Map<String, dynamic>>[].obs;
  var isAscending = true.obs;
  RxList<bool> initialVisibleKpiCards = [true, true, true].obs;
  RxList<bool> initialInvisibleKpiCards = [false, false, false].obs;
  RxList<String> quickFactLabels = ['', '', ''].obs;
  RxList<String> quickFactValues = ['', '', ''].obs;

  void toggleVisibleCharts(int index) {
    initialVisibleKpiCards[index] = false;
    initialInvisibleKpiCards[index] = true;
    allChartsVisibility(index);
    update();
  }

  void toggleHiddenCharts(int index) {
    initialVisibleKpiCards[index] = true;
    initialInvisibleKpiCards[index] = false;
    allChartsVisibility(index);
    update();
  }

  void toggleChartsVisibility(int columnIndex) {
    chartVisibility[columnIndex] = !chartVisibility[columnIndex];

    update();
  }

  void allChartsVisibility(int columnIndex) {
    chartVisibility[columnIndex] = true;

    update();
  }

  Future<void> loadJsonDataAsync() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/json_data.json');
      final List<dynamic> jsonData = json.decode(jsonString);

      final List<Map<String, dynamic>> data = jsonData.map((item) {
        if (item is Map<String, dynamic>) {
          return item;
        } else {
          return Map<String, dynamic>.from(item);
        }
      }).toList();

      var targetItems = data.where((item) => item["componentId"] == 9);

      for (var item in targetItems) {
        var dynamicGrid = item['kpiResultDto'][0]['dynamicGrid'];

        columns
            .assignAll(List<Map<String, dynamic>>.from(dynamicGrid['columns']));
        rows.assignAll(List<Map<String, dynamic>>.from(dynamicGrid['raws']));
      }
    } catch (e) {
      print("Error loading JSON data: $e");
    }
  }

  Future<void> loadKpiCardDataAsync() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/json_data.json');
      final List<dynamic> jsonData = json.decode(jsonString);

      final List<Map<String, dynamic>> data =
          List<Map<String, dynamic>>.from(jsonData);

      kpiData.clear();

      var targetItems = data.where((item) => item["componentId"] == 3);

      for (var item in targetItems) {
        var kpiResults = item['kpiResultDto'];

        for (var kpi in kpiResults) {
          var kpiAlias = kpi['kpiAlias'];
          var current = kpi['current'];
          var dataPoints = kpi['data'];

          List<ChartData> chartData = dataPoints.map<ChartData>((dataPoint) {
            DateTime date =
                DateFormat("M/d/yyyy h:mm:ss a").parse(dataPoint['date']);
            double xValue = date.millisecondsSinceEpoch.toDouble();
            double yValue = dataPoint['total'].toDouble();

            return ChartData(xValue, yValue);
          }).toList();

          kpiData.add({
            'kpiAlias': kpiAlias,
            'current': current,
            'data': chartData,
          });
        }
      }

      if (kpiData.length > 6) {
        kpiData.value = kpiData.sublist(0, 6);
      }
    } catch (e) {
      print("Error loading KPI card data: $e");
    }
  }

  void sortColumn(String columnName) {
    isAscending.value = !isAscending.value;

    rows.sort((a, b) {
      var aValue = a[columnName];
      var bValue = b[columnName];

      if (aValue == null && bValue == null) return 0;
      if (aValue == null) return isAscending.value ? -1 : 1;
      if (bValue == null) return isAscending.value ? 1 : -1;

      bool isNumeric = (aValue is num) && (bValue is num);

      if (isNumeric) {
        if (isAscending.value) {
          return aValue.compareTo(bValue);
        } else {
          return bValue.compareTo(aValue);
        }
      } else {
        if (isAscending.value) {
          return aValue.toString().compareTo(bValue.toString());
        } else {
          return bValue.toString().compareTo(aValue.toString());
        }
      }
    });
  }
}
