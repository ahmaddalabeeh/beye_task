import 'package:get/get.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class LoanController extends GetxController {
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

    update();
  }

  void toggleHiddenCharts(int index) {
    initialVisibleKpiCards[index] = true;
    initialInvisibleKpiCards[index] = false;

    update();
  }

  Future<void> loadJsonDataAsync() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/json_data.json');
      final List<dynamic> jsonData = json.decode(jsonString);

      final List<Map<String, dynamic>> data =
          List<Map<String, dynamic>>.from(jsonData);

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

      kpiData.clear(); // Clear any existing data to avoid conflict

      var targetItems = data.where((item) => item["componentId"] == 3);

      for (var item in targetItems) {
        var kpiResults = item['kpiResultDto'];

        for (var kpi in kpiResults) {
          var kpiAlias = kpi['kpiAlias'];
          var current = kpi['current'];
          var dataPoints = kpi['data'];

          kpiData.add({
            'kpiAlias': kpiAlias,
            'current': current,
            'data': dataPoints,
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

      if (isAscending.value) {
        return aValue.compareTo(bValue);
      } else {
        return bValue.compareTo(aValue);
      }
    });
  }
}
