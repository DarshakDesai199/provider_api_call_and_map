import 'package:flutter/cupertino.dart';

class CounterController extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void setCount() {
    _count++;
    notifyListeners();
  }

  int _sample = 0;

  int get sample => _sample;

  set sample(int value) {
    _sample = value;
    notifyListeners();
  }
}
