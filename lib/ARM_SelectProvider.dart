import 'package:flutter/cupertino.dart';

class ARM_Selection_provider with ChangeNotifier {
  String? _selecteditem;

  String? get selected => _selecteditem;

  void setSelected(String key) {
    _selecteditem = key;
    notifyListeners();
  }
}