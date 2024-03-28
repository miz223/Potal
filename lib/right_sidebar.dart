import 'package:flutter/material.dart';

class RightSidebar extends StatelessWidget {
  const RightSidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200, // サイドバーの幅
      color: Colors.green, // サイドバーの色
      // サイドバーの内容
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text("右サイドバー"),
          // 他のウィジェット
        ],
      ),
    );
  }
}