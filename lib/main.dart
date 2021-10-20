import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/models.dart';
import 'navigation/app_router.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appStateManager = AppStateManager();
  // 【状態マネージャ追加案】（ChangeNotifier継承クラス）
  // 別途、models/profile_managerを作成
  // final _profileManager = ProfileManager();
  late AppRouter _appRouter;

  @override
  void initState() {
    /// 【ポイント】
    /// initState()使用する前にアプリルーターが初期化
    /// 状態マネージャーをリッスンし、状態の変化に基づいて、
    /// ページルートのリストを構成し、状態マネージャーを接続
    /// 状態が変化すると、ルーターはナビゲーターを新しいページのセット
    /// で再構成
    _appRouter = AppRouter(
      appStateManager: _appStateManager,
      // 【状態マネージャ追加案】
      // profileManager: _profileManager,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => _appStateManager,
        ),
        // 【状態マネージャ追加案】
        // ChangeNotifierProvider(
        //   create: (context) => _profileManager,
        // )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyApp',
        home: Router(
          routerDelegate: _appRouter,
          backButtonDispatcher: RootBackButtonDispatcher(),
        ),
      ),
    );
  }
}
