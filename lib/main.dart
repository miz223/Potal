import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'left_sidebar.dart';
import 'main_content.dart';
import 'right_sidebar.dart';

void main() {
  runApp(
    ProviderScope( // RiverpodのProviderScopeを追加
      child: const MyApp(),
    ),
  );
}

// デバイスのサイズに基づいたUIの表示状態を管理するNotifier
class ResponsiveLayoutNotifier extends ChangeNotifier {
  bool _showRightSidebar = true;
  bool _showLeftSidebar = true;
  bool _showHamburgerMenu = false; // ハンバーガーメニューの表示状態を追加

  // タブレットとスマホのサイズを定義
  static const double tabletBreakpoint = 1200.0;
  static const double phoneBreakpoint = 600.0;
  static const double sidebarWidth = 450.0; // サイドバーの横幅を定義

  // 右サイドバーの表示状態を取得
  bool get showRightSidebar => _showRightSidebar;

  // 左サイドバーの表示状態を取得
  bool get showLeftSidebar => _showLeftSidebar;

  // ハンバーガーメニューの表示状態を取得
  bool get showHamburgerMenu => _showHamburgerMenu;

  // サイズ変更時に呼び出されるメソッド
  void updateLayout(double width) {
    if (width < phoneBreakpoint) {
      // スマホサイズ
      _showRightSidebar = false;
      _showLeftSidebar = false;
      _showHamburgerMenu = true; // ハンバーガーメニューを表示
    } else if (width < tabletBreakpoint) {
      // タブレットサイズ
      _showRightSidebar = false;
      _showLeftSidebar = true;
      _showHamburgerMenu = false;
    } else {
      // PCサイズ
      _showRightSidebar = true;
      _showLeftSidebar = true;
      _showHamburgerMenu = false;
    }
    notifyListeners(); // UIの更新を通知
  }
}

// NotifierProviderを定義
final responsiveLayoutNotifierProvider = ChangeNotifierProvider<ResponsiveLayoutNotifier>((ref) {
  return ResponsiveLayoutNotifier();
});

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showHamburgerMenu = ref.watch(responsiveLayoutNotifierProvider).showHamburgerMenu;
    return MaterialApp(
      home: Scaffold(
        appBar: showHamburgerMenu // スマホサイズのときのみAppBarを表示
            ? AppBar(
                // ハンバーガーメニューのアイコンを表示
                leading: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    // ハンバーガーメニューのアクションを定義
                    Scaffold.of(context).openDrawer();
                  },
                ),
              )
            : null,
        drawer: const LeftSidebar(), // Drawerとして左サイドバーを追加
        body: LayoutBuilder(
          builder: (context, constraints) {
            // レイアウトのサイズに基づいて状態を更新
            ref.read(responsiveLayoutNotifierProvider).updateLayout(constraints.maxWidth);

            // 状態に基づいてウィジェットを表示
            return Row(
              children: [
                if (ref.watch(responsiveLayoutNotifierProvider).showLeftSidebar)
                  const LeftSidebar(), // 左サイドバー
                Expanded(
                  child: const MainContent(), // メインコンテンツを可変に
                ),
                if (ref.watch(responsiveLayoutNotifierProvider).showRightSidebar)
                  const RightSidebar(), // 右サイドバー
              ],
            );
          },
        ),
      ),
    );
  }
}