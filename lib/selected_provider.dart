import 'package:flutter/cupertino.dart';

class SelectionProvider with ChangeNotifier {
  String? _selected;

  String? get selected => _selected;

  void setSelected(String key) {
    _selected = key;
    notifyListeners();
  }
}