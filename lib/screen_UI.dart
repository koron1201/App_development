import 'package:flutter/material.dart';
//画面が小さくて入りきらないときはスクロール可能にするui設定
Widget screen_UI(BuildContext context, String title, Widget column) {
  return Scaffold(
    appBar: AppBar(
      title: Text(title),
      backgroundColor: Colors.blue,
    ),
    body: LayoutBuilder( // 画面サイズ（幅や高さ）を取得
      builder: (context, constraints) { // constraintsで画面の最大の高さを取得
        return SingleChildScrollView( // 長さが足りないときにスクロール可能にする
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight), // 表示デバイスが大きいときに大きさを変えて埋める
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: column, // 渡された Column ウィジェットをここに配置
            ),
          ),
        );
      },
    ),
  );
}

Widget return_button(BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      Navigator.pop(context);
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.green,
      foregroundColor: Colors.black,
      padding: const EdgeInsets.symmetric(

        vertical: 10,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    child: const Text('戻る', style: TextStyle(fontSize: 30)),
  );
}