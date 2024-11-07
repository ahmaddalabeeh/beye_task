import 'package:beye_group/helpers/helpers.dart';
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
              DataGridCell(
                columnName: '#',
                value: index + 1,
              ),
              ...columns.map<DataGridCell>((column) {
                final columnName = column['name'];
                final rawValue = row[columnName] ?? '';
                return DataGridCell(
                  columnName: columnName,
                  value: Helpers().formatNumber(rawValue),
                );
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
          child: Text(
            cell.value.toString(),
            style: const TextStyle(color: AppColors.black),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        );
      }).toList(),
    );
  }
}
