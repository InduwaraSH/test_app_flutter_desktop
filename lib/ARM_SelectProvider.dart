import 'package:flutter/cupertino.dart';

class ARM_Selection_provider with ChangeNotifier {
  String? _selecteditem;
  String? _type;

  String? get selected => _selecteditem;
  String? get type => _type;

  void setSelected(String key) {
    _selecteditem = key;
    notifyListeners();
  }

  void setType(String type) {
    _type = type;
    notifyListeners();
  }
}
