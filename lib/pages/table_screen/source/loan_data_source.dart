import 'package:beye_group/helpers/helpers.dart';
import 'package:beye_group/shared/widgets/main_text.dart';
import 'package:beye_group/singletons/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class LoanDataSource extends DataGridSource {
  final List<DataGridRow> _dataGridRows;

  LoanDataSource(
      List<Map<String, dynamic>> rows, List<Map<String, dynamic>> columns)
      : _dataGridRows = rows.asMap().entries.map<DataGridRow>((entry) {
          int index = entry.key;
          Map<String, dynamic> row = entry.value;

          return DataGridRow(
            cells: [
              DataGridCell<int>(
                columnName: '#',
                value: index + 1,
              ),
              ...columns.map<DataGridCell>((column) {
                final columnName = column['name'];
                final rawValue = row[columnName] ?? '';

                if (rawValue is num) {
                  return DataGridCell<String>(
                    columnName: columnName,
                    value: Helpers().formatNumber(rawValue.toDouble()),
                  );
                } else {
                  return DataGridCell<String>(
                    columnName: columnName,
                    value: rawValue.toString(),
                  );
                }
              }),
            ],
          );
        }).toList();

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((cell) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.grey, width: 0.1),
            color: AppColors.white,
          ),
          child: MainText(
              text: cell.value.toString(),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              color: AppColors.black),
        );
      }).toList(),
    );
  }
}
