import 'package:flutter/material.dart';

class ActualOptionProvider extends ChangeNotifier {
  int _selectedOption = 0;

  int get selectedOption => _selectedOption;

  set selectedOption(int i) {
    _selectedOption = i;
    notifyListeners();
  }
}
