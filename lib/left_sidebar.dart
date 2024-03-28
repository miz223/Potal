import 'package:flutter/material.dart';

class LeftSidebar extends StatelessWidget {
  const LeftSidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200, // サイドバーの幅
      color: Colors.blue, // サイドバーの色
      // サイドバーの内容
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text("左サイドバー"),
          // 他のウィジェット
        ],
      ),
    );
  }
}