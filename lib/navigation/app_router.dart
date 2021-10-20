import 'package:flutter/material.dart';

import '../models/models.dart';
import '../screens/screens.dart';

// RouterDelegateにより、
// ルーターがアプリの状態の変化をリッスンしてナビゲーターの構成を再構築
class AppRouter extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  final AppStateManager appStateManager;
  // 【状態マネージャ追加案】
  // final ProfileManager profileManager;

  AppRouter({
    required this.appStateManager,
    // 【状態マネージャ追加案】
    // required this.profileManager,
  }) : navigatorKey = GlobalKey<NavigatorState>() {
    appStateManager.addListener(notifyListeners);
    // 【状態マネージャ追加案】
    // profileManager.addListener(notifyListeners);
  }

  @override
  void dispose() {
    appStateManager.removeListener(notifyListeners);
    // 【状態マネージャ追加案】
    // profileManager.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _handlePopPage,
      pages: [
        /// 【ポイント】
        /// 状態管理によって、表示したいページとしている
        /// 「context.read<AppStateManager>().xxx」等の関数で状態を変化させる
        /// ことで、以下の判定により画面遷移
        if (!appStateManager.isInitialized) SplashScreen.page(),
        if (appStateManager.isInitialized)
          Home.page(appStateManager.getSelectedTab),
        // 【状態マネージャ追加案】
        // 何かしらの関数実行にて、クラス変数の状態を変化させ、画面遷移させる
        // if (profileManager.didSelectUser)
        // 【画面追加案】
        //   ProfileScreen.page(profileManager.getUser),
      ],
    );
  }

  /// 【ポイント】
  /// ポップイベントの処理
  // ユーザーが[戻る]ボタンをタップするか（Android）、
  // システムの[戻る]ボタンイベントをトリガーすると実施させることを
  // 各画面によって定義可能
  bool _handlePopPage(Route<dynamic> route, result) {
    if (!route.didPop(result)) {
      return false;
    }

    // 【画面追加案】
    // if (route.settings.name == MyAppPages.profilePath) {
    //   profileManager.tapOnProfile(false);
    // }
    return true;
  }

  @override
  Future<void> setNewRoutePath(configuration) async => () {};
}
