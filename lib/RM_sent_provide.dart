import 'package:flutter/cupertino.dart';

class RM_Sent with ChangeNotifier {
  String? _s_num;
  String? _poc;
  String? _letter_no;
  String? _date_informed;
  bool? _selected;

  String? get s_num => _s_num;
  String? get poc => _poc;
  String? get letter_no => _letter_no;
  String? get date_informed => _date_informed;
  bool? get selected => _selected;

  void setSNum(String key) {
    _s_num = key;
    notifyListeners();
  }

  void setPOC(String key) {
    _poc = key;
    notifyListeners();
  }

  void setLetterNo(String key) {
    _letter_no = key;
    notifyListeners();
  }

  void setDateInformed(String key) {
    _date_informed = key;
    notifyListeners();
  }

  void setSelected(bool key) {
    _selected = key as bool?;
    notifyListeners();
  }
}
