import 'package:flutter/cupertino.dart';

class TabInfo {
  Widget? leading;

  String navTitle;
  List<Widget> actions;

  bool searchBar;

  TabInfo(
      {required this.navTitle,
      this.actions = const [],
      this.searchBar = false,
      this.leading});
}
