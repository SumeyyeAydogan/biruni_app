import 'package:flutter/material.dart';

class DrawerState extends ChangeNotifier {
  bool _isYonetimOpen = false;
  bool _isFakulteOpen = false;
  bool _isRektorlukBolumleriOpen = false;
  bool _isYayinlarimizOpen = false;

  bool get isYonetimOpen => _isYonetimOpen;
  bool get isFakulteOpen => _isFakulteOpen;
  bool get isRektorlukBolumleriOpen => _isRektorlukBolumleriOpen;
  bool get isYayinlarimizOpen => _isYayinlarimizOpen;

  void toggleYonetim() {
    _isYonetimOpen = !_isYonetimOpen;
    notifyListeners();
  }

  void toggleFakulte() {
    _isFakulteOpen = !_isFakulteOpen;
    notifyListeners();
  }

  void toggleRektorlukBolumleri() {
    _isRektorlukBolumleriOpen = !_isRektorlukBolumleriOpen;
    notifyListeners();
  }

  void toggleYayinlarimiz() {
    _isYayinlarimizOpen = !_isYayinlarimizOpen;
    notifyListeners();
  }
}
