import 'package:flutter/material.dart';

class productDetailsProvider extends ChangeNotifier {
  int selectImageIndex = 0;
  changeImage(index) {
    selectImageIndex = index;
    notifyListeners();
  }

  int selectedColorIndex = 0;
  colorSelect(index) {
    selectedColorIndex = index;
    notifyListeners();
  }

  
 
}
