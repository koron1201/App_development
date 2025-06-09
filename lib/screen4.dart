import 'package:flutter/material.dart';
import 'screen4_1keyaki.dart';
import 'screen4_2komorebi.dart';
import 'screen4_3hato.dart';
import 'dart:ui';

class Function4_Screen extends StatefulWidget {
  final String title;
  const Function4_Screen({super.key, required this.title});

  @override
  Screen4_Structure createState() => Screen4_Structure();
}

class Screen4_Structure extends State<Function4_Screen> {
  Widget cafeteriaButton(BuildContext context, String title, Widget nextScreen) {
    return GlassCard(
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => nextScreen));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.withOpacity(0.8),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 8,
            shadowColor: Colors.cyanAccent.withOpacity(0.6),
          ),
          child: Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget glass_return_button(BuildContext context) {
    return GlassCard(
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.greenAccent.withOpacity(0.7),
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
    final screen4_column = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 40),
        const Center(
          child: Text(
            '食堂の選択',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        const SizedBox(height: 40),
        cafeteriaButton(context, '欅', CafeteriaKeyaki()),
        const SizedBox(height: 20),
        cafeteriaButton(context, 'komorebi', CafeteriaKomorebi()),
        const SizedBox(height: 20),
        cafeteriaButton(context, 'HATO CAFE', CafeteriaHato()),
        const SizedBox(height: 60),
        glass_return_button(context),
      ],
    );

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
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
              // 左上の丸いグラデーション円（必要なら）
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
    // 右上の丸いグラデーション円（これがなかったら追加）
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
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: SingleChildScrollView(child: screen4_column),
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
      margin: const EdgeInsets.symmetric(vertical: 6),
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
            color: Colors.blueAccent.withOpacity(0.12),
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
