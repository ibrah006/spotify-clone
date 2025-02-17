import 'package:flutter/material.dart';
import 'package:spotify/table/table_column.dart';

class CustomTable extends StatelessWidget {
  final List<TableColumn> columns;
  final List<TableRow> rows;

  const CustomTable({super.key, required this.columns, required this.rows});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Theme(
          data: ThemeData(
              iconTheme: IconThemeData(color: Colors.grey.shade400, size: 20)),
          child: DefaultTextStyle(
            style: textTheme.bodyLarge!.copyWith(color: Colors.grey.shade400),
            child: Row(
                children: List.generate(columns.length, (index) {
              final tableColumn = columns[index];

              return Expanded(
                  flex: tableColumn.columnFlex,
                  child: tableColumn.label != null
                      ? Text(tableColumn.label!)
                      : tableColumn.child!);
            })),
          ),
        ),
        SizedBox(height: 12),
        Divider(
          thickness: .85,
          color: Colors.grey.shade800.withAlpha(200),
        ),
        SizedBox(height: 5),

        // Table rows
        ...List.generate(rows.length, (index) {
          final tableRow = rows[index];

          return InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                  children: List.generate(columns.length, (index) {
                final cellFlex = columns[index].columnFlex;

                final cellContent = tableRow.children[index];

                return Expanded(flex: cellFlex, child: cellContent);
              })),
            ),
          );
        })
      ],
    );
  }
}
