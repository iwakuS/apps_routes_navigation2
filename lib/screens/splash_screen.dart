import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class SplashScreen extends StatefulWidget {
  /// 【ポイント】
  /// AppRouterクラスでif文を利用し、画面遷移利用するためのpage定義
  static MaterialPage page() {
    return MaterialPage(
      name: MyAppPages.splashPath,
      key: ValueKey(MyAppPages.splashPath),
      child: const SplashScreen(),
    );
  }

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    /// 【ポイント】
    /// 状態マネージャーの関数を利用し、画面遷移誘発
    context.read<AppStateManager>().initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('SplashScreen'),
            Text('Initializing...'),
          ],
        ),
      ),
    );
  }
}
