import 'package:flutter/material.dart';

class MainContent extends StatelessWidget {
  const MainContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.grey, // メインコンテンツの色
        child: Center(
          child: const Text("メインコンテンツ"),
          // メインコンテンツの内容
        ),
      ),
    );
  }
}