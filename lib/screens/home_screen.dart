import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class Home extends StatefulWidget {
  /// 【ポイント】
  /// AppRouterクラスでif文を利用し、画面遷移利用するためのpage定義
  static MaterialPage page(int currentTab) {
    return MaterialPage(
      name: MyAppPages.home,
      key: ValueKey(MyAppPages.home),
      child: Home(
        currentTab: currentTab,
      ),
    );
  }

  const Home({
    Key? key,
    required this.currentTab,
  }) : super(key: key);

  final int currentTab;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static List<Widget> pages = <Widget>[
    const Center(child: Text('1')),
    const Center(child: Text('2')),
    const Center(child: Text('3')),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateManager>(
      builder: (
        context,
        appStateManager,
        child,
      ) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('MyApp'),
          ),
          body: IndexedStack(
            index: widget.currentTab,
            children: pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: widget.currentTab,
            onTap: (index) {
              /// 【ポイント】
              /// 状態マネージャーの関数を利用し、画面遷移誘発
              context.read<AppStateManager>().goToTab(index);
            },
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.explore),
                label: '1',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.book),
                label: '2',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: '3',
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            /// 【ポイント】
            /// 状態マネージャーの関数を利用し、画面遷移誘発
            onPressed: context.read<AppStateManager>().unInitializeApp,
          ),
        );
      },
    );
  }
}
