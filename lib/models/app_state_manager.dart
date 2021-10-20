import 'dart:async';

import 'package:flutter/material.dart';

// タブ管理用
class MyAppTab {
  static const int explore = 0;
  static const int recipes = 1;
  static const int toBuy = 2;
}

// アプリの状態管理クラス
class AppStateManager extends ChangeNotifier {
  bool _initialized = false;
  int _selectedTab = MyAppTab.explore;

  bool get isInitialized => _initialized;
  int get getSelectedTab => _selectedTab;

  void initializeApp() {
    Timer(
      const Duration(milliseconds: 2000),
      () {
        _initialized = true;
        notifyListeners();
      },
    );
  }

  void goToTab(index) {
    _selectedTab = index;
    notifyListeners();
  }

  void unInitializeApp() {
    _initialized = false;
    notifyListeners();
  }
}
