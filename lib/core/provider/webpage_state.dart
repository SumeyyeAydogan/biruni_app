import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../product/constants/url_constants.dart';

import 'package:flutter/material.dart';

class WebPageState extends ChangeNotifier {
  bool _isLoading = true; // Başlangıçta yükleme durumu açık

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners(); // Durum değiştiğinde dinleyicileri bilgilendir
  }
}
