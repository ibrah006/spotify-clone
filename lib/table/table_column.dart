import 'package:flutter/cupertino.dart';

class TableColumn {
  String? label;
  Widget? child;
  int columnFlex;

  TableColumn({
    this.label,
    required this.child,
    required this.columnFlex,
  }) {
    if (label == null && child == null) {
      throw ArgumentError('At least one of label or child must be provided.');
    }
  }
}
