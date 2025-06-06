import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:new_sample001/screen2_10.dart';
import 'package:new_sample001/screen2_12.dart';
import 'package:new_sample001/screen2_3.dart';
import 'package:new_sample001/screen2_6.dart';
import 'package:new_sample001/screen2_8.dart';
import 'package:new_sample001/screen2_campusMap.dart';
import 'package:new_sample001/screen_UI.dart';

//screen2の３～１２号館の選択ボタンのui設定
//横幅を画面の1/3の大きさに設定
//スクリーン2の号館の選択ボタンは全部これ
Widget screen2_button_custom(
  BuildContext context,
  String title,
  Widget nextScreen,
) {
  return LayoutBuilder(
    //横幅のお長さを取得
    builder: (BuildContext context, BoxConstraints constraints) {
      final double buttonWidth = constraints.maxWidth * 1 / 3; // 横幅の1/3の大きさに設定
      return SizedBox(
        width: buttonWidth,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => nextScreen), // 指定された
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 20), // ボタンの高さを調整
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      );
    },
  );
}

class Fuction2_Screen extends StatelessWidget {
  final String title;

  const Fuction2_Screen({super.key, required this.title});

  Widget glass_button(BuildContext context, String title, Widget nextScreen, List<Color> colors, Color glow, IconData icon) {
    return GlassCard(
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => nextScreen),
            );
          },
          icon: Icon(icon, color: Colors.white, size: 28),
          label: Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          style: ElevatedButton.styleFrom(
            backgroundColor: colors.first.withOpacity(0.85),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 18),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 8,
            shadowColor: glow,
          ),
        ),
      ),
    );
  }

  Widget glass_return_button(BuildContext context) {
    return GlassCard(
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.greenAccent.withOpacity(0.7),
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 6,
            shadowColor: Colors.greenAccent.withOpacity(0.3),
          ),
          child: const Text('戻る', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 背景グラデーション
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF23243A), Color(0xFF0F2027)],
                ),
              ),
            ),
          ),
          // 装飾的なグラデーションエフェクト
          Positioned(
            top: -60,
            left: -60,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.cyan.withOpacity(0.18), Colors.blue.withOpacity(0.10)],
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 180,
            right: -40,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple.withOpacity(0.13), Colors.pink.withOpacity(0.10)],
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // メインUI
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 10),
                    GlassCard(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
                        child: Column(
                          children: const [
                            Text(
                              '号館の選択\n(施錠されていない教室のみ表示)',
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    glass_button(context, '3号館', Screen2_3(title: '3号館'), [Colors.cyan, Colors.blue], Colors.cyanAccent.withOpacity(0.4), Icons.apartment),
                    const SizedBox(height: 16),
                    glass_button(context, '6号館', Screen2_6(title: '6号館'), [Colors.green, Colors.teal], Colors.greenAccent.withOpacity(0.4), Icons.apartment),
                    const SizedBox(height: 16),
                    glass_button(context, '8号館', Screen2_8(title: '8号館'), [Colors.orange, Colors.red], Colors.orangeAccent.withOpacity(0.4), Icons.apartment),
                    const SizedBox(height: 16),
                    glass_button(context, '10号館', Screen2_10(title: '10号館'), [Colors.purple, Colors.indigo], Colors.purpleAccent.withOpacity(0.4), Icons.apartment),
                    const SizedBox(height: 16),
                    glass_button(context, '12号館', Screen2_12(title: '12号館'), [Colors.pink, Colors.redAccent], Colors.pinkAccent.withOpacity(0.4), Icons.apartment),
                    const SizedBox(height: 28),
                    glass_button(context, 'キャンパスマップ', Screen2_campus_map(title: 'キャンパスマップ'), [Colors.lightBlueAccent, Colors.blueAccent], Colors.lightBlueAccent.withOpacity(0.4), Icons.map),
                    const SizedBox(height: 24),
                    glass_return_button(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GlassCard extends StatelessWidget {
  final Widget child;
  const GlassCard({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.10), width: 1.2),
        gradient: LinearGradient(
          colors: [Colors.white.withOpacity(0.10), Colors.white.withOpacity(0.04)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.cyanAccent.withOpacity(0.10),
            blurRadius: 24,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: child,
        ),
      ),
    );
  }
}
